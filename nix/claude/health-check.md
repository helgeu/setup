# Application Health Check — Skill Reference

Comprehensive workflow for diagnosing application health via Azure Application Insights, creating ADO bugs, and fixing code.

## Prerequisites

Before starting, verify access and gather context:

```bash
# Verify Azure login
az account show

# List available subscriptions
az account list --query "[].{name:name, id:id, isDefault:isDefault}" -o table
```

Ask the user:
1. Which subscription(s) to check?
2. ADO organization URL (e.g., `https://dev.azure.com/<your-org>`)
3. ADO project name (e.g., `<your-project>`)
4. Parent work item — all bugs created will be linked as children of this item. Either:
   - Provide an existing work item ID (e.g., a Feature or Epic already tracking this area)
   - Or say "create new" — a new Feature will be created titled `Health Check <date>` to group the bugs under

Read `~/.claude/ado_cli_reference.md` for ADO CLI flag rules.

Store session variables:
```bash
ORG="https://dev.azure.com/<org>"
PROJ="<project>"
PARENT_ID="<work-item-id>"
```

---

## Phase 1: Discovery

List all Application Insights resources in the selected subscription(s):

```bash
az resource list \
  --resource-type "Microsoft.Insights/components" \
  --subscription "<subscription-id>" \
  --query "[].{name:name, resourceGroup:resourceGroup, location:location}" \
  -o table
```

Present the list. Ask the user:
- Which resources to check? (default: all)
- Time window? (default: `24h`, options: `1h`, `6h`, `24h`, `7d`, `30d`)

Map time window to both KQL `ago()` and CLI `--offset` parameters.

---

## Phase 2: Telemetry Analysis

Run these 5 queries per selected App Insights resource. Replace `TIMEWINDOW` with the chosen window (e.g., `24h`).

### Query 1: Exceptions

```bash
az monitor app-insights query \
  --app "<name>" -g "<rg>" \
  --analytics-query '
    exceptions
    | where timestamp > ago(TIMEWINDOW)
    | summarize
        count_ = count(),
        firstSeen = min(timestamp),
        lastSeen = max(timestamp),
        sampleMessage = take_any(outerMessage)
      by problemId, type, outerType, assembly
    | order by count_ desc
    | take 50
  ' \
  --offset TIMEWINDOW \
  -o json
```

### Query 2: Failed Requests

```bash
az monitor app-insights query \
  --app "<name>" -g "<rg>" \
  --analytics-query '
    requests
    | where timestamp > ago(TIMEWINDOW)
    | where success == false
    | summarize
        count_ = count(),
        avgDuration = avg(duration),
        firstSeen = min(timestamp),
        lastSeen = max(timestamp),
        sampleUrl = take_any(url)
      by name, resultCode, performanceBucket
    | order by count_ desc
    | take 50
  ' \
  --offset TIMEWINDOW \
  -o json
```

### Query 3: Dependency Failures

```bash
az monitor app-insights query \
  --app "<name>" -g "<rg>" \
  --analytics-query '
    dependencies
    | where timestamp > ago(TIMEWINDOW)
    | where success == false
    | summarize
        count_ = count(),
        avgDuration = avg(duration),
        firstSeen = min(timestamp),
        lastSeen = max(timestamp)
      by type, target, name, resultCode
    | order by count_ desc
    | take 50
  ' \
  --offset TIMEWINDOW \
  -o json
```

### Query 4: Error Traces

```bash
az monitor app-insights query \
  --app "<name>" -g "<rg>" \
  --analytics-query '
    traces
    | where timestamp > ago(TIMEWINDOW)
    | where severityLevel >= 3
    | summarize
        count_ = count(),
        firstSeen = min(timestamp),
        lastSeen = max(timestamp),
        sampleMessage = take_any(message)
      by severityLevel, sdkVersion, cloud_RoleInstance
    | order by count_ desc
    | take 50
  ' \
  --offset TIMEWINDOW \
  -o json
```

### Query 5: Custom Error Events

```bash
az monitor app-insights query \
  --app "<name>" -g "<rg>" \
  --analytics-query '
    customEvents
    | where timestamp > ago(TIMEWINDOW)
    | where name contains "error" or name contains "fail" or name contains "exception"
    | summarize
        count_ = count(),
        firstSeen = min(timestamp),
        lastSeen = max(timestamp)
      by name
    | order by count_ desc
    | take 20
  ' \
  --offset TIMEWINDOW \
  -o json
```

### Parsing Query Results

The `az monitor app-insights query` returns nested JSON: `tables[0].columns` (schema) and `tables[0].rows` (data). Parse by mapping column names to row values.

### Deduplication

Apply 4 layers before presenting results:

1. **Same exception type + assembly** = same root cause (even if `problemId` differs)
2. **Failed request with matching dependency failure** (same `operation_Id` timeframe) = dependency is the root cause, not the request itself
3. **Same `resultCode` + `target` across multiple apps** = shared external dependency failure (cascading)
4. **Traces at `severityLevel >= 3` matching exception messages** = same incident, don't double-count

### Severity Classification

| Severity | Criteria |
|----------|----------|
| Critical | >100 occurrences OR affects >1 app OR 5xx on key endpoints |
| High | 10–100 occurrences OR dependency failures |
| Medium | 1–10 occurrences |
| Low | Single occurrence, no recent recurrence |

### Output

Present a consolidated error table:

| # | Severity | App(s) | Error Type | Count | First Seen | Last Seen | Root Cause Hint |
|---|----------|--------|------------|-------|------------|-----------|-----------------|

---

## Phase 3: Root Cause Analysis

For each error cluster starting with Critical, run deeper queries.

### Stack Trace Details

```bash
az monitor app-insights query \
  --app "<name>" -g "<rg>" \
  --analytics-query '
    exceptions
    | where timestamp > ago(TIMEWINDOW)
    | where problemId == "PROBLEM_ID"
    | project timestamp, outerMessage, outerType, innermostMessage, innermostType, details
    | take 5
  ' \
  --offset TIMEWINDOW \
  -o json
```

### Exception to Request Correlation

```bash
az monitor app-insights query \
  --app "<name>" -g "<rg>" \
  --analytics-query '
    exceptions
    | where timestamp > ago(TIMEWINDOW)
    | where problemId == "PROBLEM_ID"
    | project operation_Id
    | join kind=inner (
        requests
        | where timestamp > ago(TIMEWINDOW)
      ) on operation_Id
    | summarize count() by name, resultCode
    | order by count_ desc
  ' \
  --offset TIMEWINDOW \
  -o json
```

### Exception to Dependency Correlation

```bash
az monitor app-insights query \
  --app "<name>" -g "<rg>" \
  --analytics-query '
    exceptions
    | where timestamp > ago(TIMEWINDOW)
    | where problemId == "PROBLEM_ID"
    | project operation_Id
    | join kind=inner (
        dependencies
        | where timestamp > ago(TIMEWINDOW)
        | where success == false
      ) on operation_Id
    | summarize count() by type, target, name, resultCode
    | order by count_ desc
  ' \
  --offset TIMEWINDOW \
  -o json
```

### Timeline Analysis

```bash
az monitor app-insights query \
  --app "<name>" -g "<rg>" \
  --analytics-query '
    exceptions
    | where timestamp > ago(TIMEWINDOW)
    | where problemId == "PROBLEM_ID"
    | summarize count() by bin(timestamp, 1h)
    | order by timestamp asc
  ' \
  --offset TIMEWINDOW \
  -o json
```

### Cross-Application Correlation

For dependency failures, check if the `target` matches another monitored App Insights resource. If so, query that resource for corresponding request failures in the same timeframe. Same error appearing in multiple apps at the same time = cascading failure from shared dependency.

### Output per Cluster

Summarize:
1. What is failing (exception type, message)
2. What triggers it (which requests/endpoints)
3. What external calls fail (dependencies)
4. When it started (spike or gradual)
5. Whether it cascades across apps

---

## Phase 4: ADO Work Items

**STOP: Ask the user which bugs to create. Present the list and let them pick.**

### Ensure Parent Work Item

If the user asked to create a new parent:

```bash
az boards work-item create \
  --type "Feature" \
  --title "Health Check $(date +%Y-%m-%d)" \
  --org "$ORG" \
  --project "$PROJ" \
  -o json
```

Save the returned ID as `PARENT_ID`.

### Create Bug Work Item

For each confirmed bug:

```bash
az boards work-item create \
  --type "Bug" \
  --title "[AppName][Env] ErrorType: short description" \
  --description "$(cat <<'DESCEOF'
## Summary
Brief description of the error.

## Impact
- **Frequency**: X occurrences in last Y hours
- **Affected endpoints**: list
- **Affected apps**: list
- **First seen**: timestamp
- **Last seen**: timestamp

## Stack Trace
```
top stack trace
```

## Root Cause Analysis
What the analysis revealed.

## Dependency Failures
Which external calls fail and how they relate (if applicable).

## App Insights Query
```kql
exceptions | where problemId == "PROBLEM_ID" | where timestamp > ago(24h)
```

## Reproduction
1. The error occurs when [endpoint] is called with [conditions]
2. The dependency [target] returns [resultCode]
DESCEOF
)" \
  --fields "Microsoft.VSTS.Common.Severity=$SEVERITY" \
  --org "$ORG" \
  --project "$PROJ" \
  -o json
```

Save the returned work item ID, then link it to the parent:

```bash
az boards work-item relation add \
  --id <new-bug-id> \
  --relation-type "Parent" \
  --target-id "$PARENT_ID" \
  --org "$ORG"
```

### Severity Mapping

| Classification | ADO Severity |
|----------------|-------------|
| Critical | 1 - Critical |
| High | 2 - High |
| Medium | 3 - Medium |
| Low | 4 - Low |

### Link Related Bugs

If multiple bugs share a root cause (e.g., cascading failure):

```bash
az boards work-item relation add \
  --id <bug-id> \
  --relation-type "Related" \
  --target-id <related-bug-id> \
  --org "$ORG"
```

Note: `relation add` does NOT take `--project`.

---

## Phase 5: Code Fixes

**STOP: Ask the user which bugs to fix. Ask them to map each App Insights resource to an ADO repo name.**

### Per Bug

#### 1. Set up branch

```bash
cd /path/to/repo
git switch main && git pull
git switch -c fix/ado-WORKITEM_ID-short-description
```

#### 2. Locate and fix the code

- Use the stack trace to find the failing file and line
- Analyze the root cause from Phase 3
- Write the fix
- Write tests covering the failure scenario

#### 3. Pre-commit checks

```bash
# Run tests (detect framework from repo)
dotnet test        # .NET
npm test           # Node.js
pytest             # Python

# Secret scan
gitleaks detect --source .

# Review staged changes
git diff --cached
```

#### 4. Commit

```bash
git add <specific-files>
git commit -m "$(cat <<'EOF'
fix(<scope>): <description>

Fixes #<ADO_WORK_ITEM_ID>
EOF
)"
```

#### 5. Create PR

```bash
az repos pr create \
  --title "fix(<scope>): short description" \
  --description "$(cat <<'DESCEOF'
Fixes AB#<ADO_WORK_ITEM_ID>

## Summary
- What was broken and why
- What the fix does

## Test plan
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual verification against App Insights
DESCEOF
)" \
  --source-branch "fix/ado-WORKITEM_ID-short-description" \
  --target-branch main \
  --org "$ORG" \
  --project "$PROJ" \
  -o json
```

#### 6. Update work item

```bash
az boards work-item update \
  --id <WORKITEM_ID> \
  --state "Active" \
  --org "$ORG"
```

Note: `update` does NOT take `--project`.

---

## Phase 6: Verification (Post-Deploy)

After fixes are merged and deployed, verify the error is gone:

```bash
az monitor app-insights query \
  --app "<name>" -g "<rg>" \
  --analytics-query '
    exceptions
    | where timestamp > ago(2h)
    | where problemId == "PROBLEM_ID"
    | summarize count() by bin(timestamp, 10m)
    | order by timestamp asc
  ' \
  --offset 2h \
  -o json
```

If count drops to zero or near-zero:

```bash
az boards work-item update \
  --id <WORKITEM_ID> \
  --state "Resolved" \
  --org "$ORG"
```

---

## Behavior Rules

- **Always confirm** with the user before creating work items (Phase 4) or PRs (Phase 5)
- **Never commit secrets** — run `gitleaks detect` before every commit
- **`git switch -c`** not `git checkout -b`
- **Conventional commits**: `fix(<scope>): <description>` for bug fixes
- **Branch prefix**: `fix/` for all bug fix branches
- **ADO `update`**: uses `--org` only, NO `--project`
- **ADO `create`**: uses both `--org` and `--project`
- **`az repos pr create`** for PRs (ADO Repos, not GitHub)
- **`| take 50`** on all KQL queries to limit context size
- **Parallelize** queries across App Insights resources using sub-agents
