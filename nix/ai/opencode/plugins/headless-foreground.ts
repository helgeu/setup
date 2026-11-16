// Forces shell commands to run in the foreground for the headless agents.
//
// The pr-review, spike and error-reduction agents run through `opencode run`,
// which exits as soon as the session goes idle. A background shell command
// would notify the session when it finishes, but nothing is left to resume the
// agent: the run exits, the driver script removes its worktree, and the output
// file is never written (PR 25359, 2026-11-16).

import { Plugin } from "@opencode/plugin"

const HEADLESS_AGENTS = new Set(["pr-review", "spike", "error-reduction"])

// Background commands have no timeout; foreground commands default to 2 minutes.
// Give a converted command room for a slow build or test run.
const FOREGROUND_TIMEOUT_MS = 30 * 60 * 1000

export default Plugin.define({
  id: "headless-foreground",
  async setup(ctx) {
    await ctx.tool.hook("execute.before", (event) => {
      if (!HEADLESS_AGENTS.has(String(event.agent))) return
      const tool = String(event.tool ?? "").toLowerCase()
      if (tool !== "shell" && tool !== "bash") return

      const input = event.input as { background?: unknown; timeout?: unknown } | undefined
      if (!input || input.background !== true) return

      input.background = false
      if (typeof input.timeout !== "number" || input.timeout <= 0) {
        input.timeout = FOREGROUND_TIMEOUT_MS
      }
      console.warn(`[headless-foreground] ${event.agent}: ran a background shell command in the foreground`)
    })
  },
})
