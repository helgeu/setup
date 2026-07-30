---
name: standup
description: Summarize work activity for a standup or status update — answers "what did I do this week / yesterday / today", "what am I working on / planning next", and "do I have any blockers". Use when the user asks for a recap of what they've done, what's next, or blockers. Pulls from the local opencode session DB (via the `standup` script) and cross-references Azure DevOps (PRs, work items, pipeline/build status).
---

# Standup / activity recap

A standup is a **meeting frame**, not a date window. `standup` / `standup today`
answers the standup for *today's* meeting:

1. **What did I do?** — yesterday / since the last standup (the `did` list)
2. **What am I planning to do today?** — current open todos (`plan`)
3. **Any blockers?** — open todos that look blocked (`blockers`)

## Step 1 — pull local activity (always)

Run the `standup` helper (see `~/.claude/scripts-reference.md`). It reads the
local opencode session DB and is the source of truth.

```bash
standup                  # standup frame: did=last active day, plan=today, blockers
standup today            # same as above
standup --json           # machine-readable; prefer this when composing a summary
# raw recaps (for "what did I literally do over X"):
standup yesterday        # just yesterday's sessions
standup week             # last 7 days
standup --days N
```

JSON shape: `{ today, did_window, did[], plan[], blockers[] }` where `today` is
the authoritative current weekday+date (e.g. `Thursday 2026-07-30`),
`did_window` is the concrete day/range the `did` list covers, each `did` entry is
`{updated, directory, title}` and each `plan`/`blockers` entry is
`{status, session, content}`.

**Never hand-write the date or weekday.** Use the `today` / `did_window` fields
verbatim in your header. Guessing the weekday is how you end up labelling a
Wednesday "tirsdag".

Map the data to the standup answers:

- **Did** = the `did` list (yesterday / last active day). Group by repo (the last
  path segment of `directory`). Collapse many sessions on the same PR/work item
  into one line. Titles are already descriptive — keep it tight.
- **Plan** = `plan` (open todos): `in_progress` first, then `pending`. This is
  scoped to recently-active sessions, so it reflects current work, not ancient
  scaffolding.
- **Blockers** = `blockers[]` (todos mentioning BLOCK/WAITING/AVVENT). Read the
  full text for the real cause.

Do **not** just dump the raw lists — synthesize. Give a tight, grouped,
high-level recap with specifics (PR/work-item numbers) the user can read aloud.

## Step 2 — enrich from Azure DevOps (when it adds signal)

Only when the user wants live status (open PRs, whether a build is green, work
item state). Use the existing helper scripts first
(`~/.claude/scripts-reference.md`): `azprs <org>` for my open PRs, `ado-my-items`
for assigned work items, `find-prs` inside a repo. Drop to raw `az` for
pipeline/build detail.

### `az boards` / `az devops invoke` gotchas (learned the hard way)

- **Never put `[System.TeamProject] = @project` in a WIQL `WHERE`** — with
  `az boards query --project ...` it silently returns an empty result set.
  Omit it; the `--project` flag already scopes the query.
- **Don't trust `[System.CreatedBy] = @me`** to find items you created — the
  az-login identity often differs from the ADO author. Filter by title
  `CONTAINS` / area / iteration / date instead.
- **API version is `7.1-preview`**, not `7.1-preview.3` — `az devops invoke`
  errors with `could not convert string to float: '7.1.3'` otherwise.

### Recipes

```bash
ORG="https://imdidev.visualstudio.com"; PROJ="Bosettingsprosjekt"

# Work items I created recently (filter by title/date, NOT @me/@project):
az boards query --org "$ORG" --project "$PROJ" \
  --wiql "SELECT [System.Id],[System.WorkItemType],[System.State],[System.Title] \
          FROM WorkItems WHERE [System.Title] CONTAINS 'SPIKE' \
          ORDER BY [System.ChangedDate] DESC"

# Comments on a work item:
az devops invoke --org "$ORG" --area wit --resource comments \
  --route-parameters project=$PROJ workItemId=<id> --api-version 7.1-preview

# Latest main builds for a pipeline (FE=510, BE=517 in Bosettingsprosjekt):
az pipelines runs list --org "$ORG" --project "$PROJ" \
  --pipeline-ids <id> --branch refs/heads/main --top 5 \
  --query "[].{id:id,num:buildNumber,result:result,finish:finishTime}" -o tsv

# Why a build failed — stages/jobs/tasks + issue messages:
az devops invoke --org "$ORG" --area build --resource timeline \
  --route-parameters project=$PROJ buildId=<id> --api-version 7.1-preview
#   -> records[] with type Stage/Phase/Job/Task; filter result=='failed';
#      Task records carry issues[].message (e.g. Trivy CVE, missing path).

# Full log of one failing task (logId from the timeline record's .log.id):
az devops invoke --org "$ORG" --area build --resource logs \
  --route-parameters project=$PROJ buildId=<id> logId=<N> --api-version 7.1-preview
#   -> .value is an array of lines, each prefixed by a ~31-char ISO timestamp.
```

A red overall build often deployed fine: check the **stage** results. A failing
smoke-test/e2e stage can still mean "app deployed to test, tests flaky/broken",
whereas a failing build/push stage (e.g. Trivy CVE) means nothing deployed.

## Step 3 — present it

Standup format, short bullets, Norwegian or English to match the user:

```
**Gjort:** …grouped, with PR/WI numbers…
**Neste:** …in_progress first, then pending…
**Blokkere:** …or "ingen"…
```

Offer to write next-steps into the user's todo file
(`~/Documents/IMDI/todo-2026.md`) when they ask — high-level, self-explanatory
items with ADO links, not internal codes.
