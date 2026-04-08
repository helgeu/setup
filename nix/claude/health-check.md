# Application Health Check — Skill Reference

Comprehensive workflow for diagnosing application health via Azure Application Insights, creating ADO bugs, and fixing code.

## Prerequisites

### Param File

Config is persisted per ADO project at `~/.claude/health-check/<org-name>-<project>.json`.

**Schema:**

```json
{
  "org": "https://dev.azure.com/<org>",
  "project": "<project>",
  "subscription": "<subscription-id>",
  "appInsights": [
    { "name": "<app-name>", "resourceGroup": "<rg>" }
  ],
  "processTemplate": "<template-name>",
  "bugFields": {
    "Microsoft.VSTS.Common.Priority": {
      "allowedValues": [],
      "required": true
    },
    "Microsoft.VSTS.Common.Severity": {
      "allowedValues": [],
      "required": false
    }
  },
  "classificationMapping": {
    "Critical": { "Priority": null, "Severity": null },
    "High": { "Priority": null, "Severity": null },
    "Medium": { "Priority": null, "Severity": null },
    "Low": { "Priority": null, "Severity": null }
  }
}
```

### Step 1: Identify the project

Ask the user for ADO org and project name. If param files already exist, list them as options:

```bash
ls ~/.claude/health-check/*.json 2>/dev/null
```

### Step 2: Load or create param file

**If param file exists** → read it, summarize to user (org, project, N App Insights resources, fields, mapping). Ask to confirm or say "rediscover" to refresh.

**If param file does not exist** → run full discovery (Step 3).

**If param file exists but is incomplete** → run discovery only for missing params, update the file.

### Step 3: Full discovery (only if no param file)

Run these checks in order. **Do not proceed past any step that fails.**

#### 3a. Verify Azure login

```bash
az account show -o json
```

If this fails, stop and tell the user to run `az login`.

#### 3b. List and select subscription

```bash
az account list --query "[].{name:name, id:id, isDefault:isDefault}" -o table
```

Ask which subscription to use.

#### 3c. Verify ADO access

```bash
az boards work-item list --org "$ORG" --project "$PROJ" --query "[].id" -o tsv | head -1
```

If this fails, the org or project values are wrong. Stop and ask again.

#### 3d. Verify Bug work item type exists

```bash
az rest --method get \
  --uri "https://dev.azure.com/$ORG_NAME/$PROJ/_apis/wit/workitemtypes?api-version=7.1" \
  -o json
```

Verify that `Bug` appears in the returned list. If not, stop and report available types.

#### 3e. Discover Bug fields and allowed values

```bash
az rest --method get \
  --uri "https://dev.azure.com/$ORG_NAME/$PROJ/_apis/wit/workitemtypes/Bug/fields?api-version=7.1&\$expand=allowedValues" \
  -o json
```

From the returned JSON, record for each field:
- `referenceName` (e.g., `Microsoft.VSTS.Common.Priority`)
- `allowedValues` array (the actual valid values)
- `alwaysRequired` (boolean)

Key fields to check:
- `Microsoft.VSTS.Common.Priority` — usually exists, but allowed values vary
- `Microsoft.VSTS.Common.Severity` — does NOT exist in all processes
- `System.Description` — check if it exists

#### 3f. Discover App Insights resources

```bash
az resource list \
  --resource-type "Microsoft.Insights/components" \
  --subscription "<subscription-id>" \
  --query "[].{name:name, resourceGroup:resourceGroup}" \
  -o table
```

Present the list. Ask the user which App Insights resources belong to this ADO project.

#### 3g. Confirm classification mapping

Present the discovered Priority and Severity allowed values. Ask the user to confirm the mapping:
- Critical → which Priority value, which Severity value
- High → which Priority value, which Severity value
- Medium → which Priority value, which Severity value
- Low → which Priority value, which Severity value

If Severity field doesn't exist, skip it.

#### 3h. Save param file

Save all discovered config to `~/.claude/health-check/<org-name>-<project>.json` using the schema above.

### Step 4: Set per-run params

These change each run and are NOT stored in the param file:

- Parent work item ID — either an existing work item or "create new" (a Feature titled `Health Check <date>`)
- Time window (default: `24h`, options: `1h`, `6h`, `24h`, `7d`, `30d`)

Store session variables:
```bash
ORG="<from param file>"
PROJ="<from param file>"
PARENT_ID="<from user>"
```

Read `~/.claude/ado_cli_reference.md` for ADO CLI flag rules and full discovery commands.

---

## Phase 1: Confirm Scope

The App Insights resources for this project are in the param file. Present them to the user:

- List the App Insights resources from the param file (`appInsights` array)
- Ask which to check this run (default: all from param file)

Map the time window (from Step 4) to both KQL `ago()` and CLI `--offset` parameters.

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

| Classification | Criteria |
|----------------|----------|
| Critical | >100 occurrences OR affects >1 app OR 5xx on key endpoints |
| High | 10–100 occurrences OR dependency failures |
| Medium | 1–10 occurrences |
| Low | Single occurrence, no recent recurrence |

Map these classifications to the `classificationMapping` in the param file when creating work items.

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

### Load Fields from Param File

Use the `bugFields` and `classificationMapping` from the param file (`~/.claude/health-check/<org>-<project>.json`). Do not re-discover unless the user says "rediscover".

### Create Bug Work Items

Create each bug **one at a time** — no batch arrays. Verify each one succeeds before the next.

**Step 1:** Write the description to a temp file using HTML (not markdown — backticks break shell interpolation):

```bash
cat << 'DESCEOF' > /tmp/bug-desc.txt
<h2>Summary</h2>
<p>Brief description of the error.</p>

<h2>Impact</h2>
<ul>
<li><b>Frequency</b>: X occurrences in last Y hours</li>
<li><b>Affected endpoints</b>: list</li>
<li><b>Affected apps</b>: list</li>
<li><b>First seen</b>: timestamp</li>
<li><b>Last seen</b>: timestamp</li>
</ul>

<h2>Stack Trace</h2>
<pre>top stack trace</pre>

<h2>Root Cause Analysis</h2>
<p>What the analysis revealed.</p>

<h2>App Insights Query</h2>
<pre>exceptions | where problemId == "PROBLEM_ID" | where timestamp > ago(24h)</pre>
DESCEOF
```

**Step 2:** Create the work item using the temp file:

```bash
az boards work-item create \
  --type "Bug" \
  --title "[AppName][Env] ErrorType: short description" \
  --description "$(cat /tmp/bug-desc.txt)" \
  --fields "<field_from_param_file>=<value_from_classificationMapping>" \
  --org "$ORG" \
  --project "$PROJ" \
  -o json
```

**Step 3:** Verify the returned JSON has the correct title and fields before proceeding to the next bug.

Save the returned work item ID, then link it to the parent:

```bash
az boards work-item relation add \
  --id <new-bug-id> \
  --relation-type "Parent" \
  --target-id "$PARENT_ID" \
  --org "$ORG"
```

### Priority and Severity Mapping

Use the `classificationMapping` from the param file. This was confirmed by the user during initial setup. Do not hardcode values.

If a field (e.g., Severity) is not in `bugFields`, omit it from `--fields` entirely.

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
