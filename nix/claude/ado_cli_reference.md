---
name: ado_cli_reference
description: Azure DevOps az boards CLI patterns - correct flags, bulk operations, org/project handling
type: reference
---

## Azure DevOps CLI Reference

### Startup: Always Confirm Org and Project

Before any `az boards` work, ask the user for:
- **Organization** (e.g., `https://dev.azure.com/<your-org>`)
- **Project** (e.g., `<your-project>`)

Store as variables for the session:
```bash
ORG="https://dev.azure.com/<org>"
PROJ="<project>"
```

### Command Flag Rules

| Command | `--org` | `--project` | Notes |
|---------|---------|-------------|-------|
| `work-item create` | Yes | Yes (required) | Only create, delete, and query need project |
| `work-item delete` | Yes | Yes (required) | Needs both --org and --project |
| `work-item update` | Yes | **No** | Will error if --project is passed |
| `work-item show` | Yes | **No** | Resolves project from org + ID |
| `work-item relation add` | Yes | **No** | |
| `work-item relation list-type` | Yes | **No** | |
| `boards query` (WIQL) | Yes | Yes (required) | |
| `repos pr show` | Yes | **No** | Resolves project from PR ID |
| `repos pr list` | Yes | Yes | Also needs `--repository` |

### Relation Types

Use display names, not reference names:
- `Parent` (not `System.LinkTypes.Hierarchy-Reverse`)
- `Child` (not `System.LinkTypes.Hierarchy-Forward`)
- `Related`, `Predecessor`, `Successor`

### Fields

- Acceptance criteria: `Microsoft.VSTS.Common.AcceptanceCriteria`
- Value area: `Microsoft.VSTS.Common.ValueArea` (values: `Business`, `Architectural`)
- State field values are process-dependent. Common: `New`, `Ready for development`, `Active`, `Resolved`, `Closed`
- **Field names and allowed values vary by process template.** Always discover them via REST API before use.

### Work Item Type Discovery (REST API)

The `az boards` CLI has no subcommand for work item type metadata. Use `az rest` against the WIT REST API.

#### List work item types in a project

```bash
az rest --method get \
  --uri "https://dev.azure.com/{org}/{project}/_apis/wit/workitemtypes?api-version=7.1" \
  -o json
```

Returns all types (Bug, Task, User Story, Epic, etc.). Verify a type exists before creating items.

#### Get fields for a work item type (with allowed values)

```bash
az rest --method get \
  --uri "https://dev.azure.com/{org}/{project}/_apis/wit/workitemtypes/{typeName}/fields?api-version=7.1&\$expand=allowedValues" \
  -o json
```

Key response fields per entry:
- `referenceName`: Full field path (e.g., `Microsoft.VSTS.Common.Priority`)
- `allowedValues`: Array of valid values (e.g., `[1, 2, 3, 4]` or `["A", "B", "C"]`)
- `alwaysRequired`: Whether the field must be set on creation

#### Discover project process template (optional)

```bash
az rest --method get \
  --uri "https://dev.azure.com/{org}/_apis/projects/{project}/properties?api-version=7.1&keys=System.ProcessTemplateType" \
  -o json
```

Known template GUIDs:
- `6b724908-ef14-45cf-84f8-768b5384da45` = Agile
- `adcc42ab-9882-485e-a3ed-7678f01f66bc` = Scrum
- `27450541-8e31-4150-9947-dc59f998fc01` = CMMI
- `b8a3a935-7e91-48b8-a94c-606d37c3e9f2` = Basic

### show/update Gotchas

- `-f` (fields) conflicts with default `--expand all`. Use `--expand none` when using `-f`, or omit `-f` and filter with `--query`.
- `--state` is a convenience flag on `update`. All other fields use `--fields "Field.Name=value"`.

### Bulk Operations

Always parallelize bulk updates:
```bash
echo "${IDS[@]}" | xargs -P 10 -I {} az boards work-item update --id {} \
  --state "Ready for development" \
  --fields "Microsoft.VSTS.Common.ValueArea=Architectural" \
  --org "$ORG" \
  --query "id" -o tsv
```

### Bulk Field Updates

When updating fields like Value Area across a hierarchy, update ALL items -- not just those matching a state filter. Fields may need updating regardless of current state.

### PR Review Threads (`az devops invoke`)

When posting inline PR comments, the API needs TWO separate top-level objects:

```json
{
  "comments": [{"parentCommentId": 0, "content": "...", "commentType": 1}],
  "threadContext": {
    "filePath": "/path/to/file.cs",
    "rightFileStart": {"line": 42, "offset": 1},
    "rightFileEnd": {"line": 48, "offset": 1}
  },
  "pullRequestThreadContext": {
    "changeTrackingId": 5,
    "iterationContext": {"firstComparingIteration": 1, "secondComparingIteration": 1}
  },
  "status": 1
}
```

- `threadContext` anchors the comment to the code. Without it, the comment floats as a general PR comment.
- `pullRequestThreadContext` links the thread to a specific iteration/change.
- **CRITICAL:** `filePath` and `rightFileStart`/`rightFileEnd` go in `threadContext`, NOT `pullRequestThreadContext`. Putting them in `pullRequestThreadContext` silently fails.
- Get `changeTrackingId` from `pullRequestIterationChanges` API.
- To delete a bad thread: DELETE the comment via `pullRequestThreadComments` resource with `commentId`.
