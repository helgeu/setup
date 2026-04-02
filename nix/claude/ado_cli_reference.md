---
name: ado_cli_reference
description: Azure DevOps az boards CLI patterns - correct flags, bulk operations, org/project handling
type: reference
---

## Azure DevOps CLI Reference

### Startup: Always Confirm Org and Project

Before any `az boards` work, ask the user for:
- **Organization** (e.g., `https://dev.azure.com/imdidev`)
- **Project** (e.g., `bosettingsprosjekt`)

Store as variables for the session:
```bash
ORG="https://dev.azure.com/<org>"
PROJ="<project>"
```

### Command Flag Rules

| Command | `--org` | `--project` | Notes |
|---------|---------|-------------|-------|
| `work-item create` | Yes | Yes (required) | Only create and query need project |
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
