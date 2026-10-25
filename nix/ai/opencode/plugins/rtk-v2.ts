// RTK OpenCode v2 plugin — rewrites bash/shell commands to use rtk for token savings.
// Requires: rtk >= 0.23.0 in PATH.
//
// This is a thin delegating plugin: all rewrite logic lives in `rtk rewrite`,
// which is the single source of truth (src/discover/registry.rs).
// To add or change rewrite rules, edit the Rust registry — not this file.
//
// OpenCode v2 plugin format: export default Plugin.define({ id, setup })
// Hook: ctx.tool.hook("execute.before", ...) intercepts tool calls before execution.

import { Plugin } from "@opencode/plugin"
import { execFile } from "node:child_process"
import { promisify } from "node:util"

const execFileAsync = promisify(execFile)

async function isRtkAvailable(): Promise<boolean> {
  try {
    await execFileAsync("which", ["rtk"])
    return true
  } catch {
    return false
  }
}

async function rewriteCommand(command: string): Promise<string | null> {
  try {
    const { stdout } = await execFileAsync("rtk", ["rewrite", command], {
      maxBuffer: 1024 * 1024, // 1MB buffer for large outputs
    })
    const rewritten = stdout.trim()
    return rewritten && rewritten !== command ? rewritten : null
  } catch {
    // rtk rewrite failed — pass through unchanged
    return null
  }
}

export default Plugin.define({
  id: "rtk",
  async setup(ctx) {
    // Check if rtk is available; if not, disable the plugin gracefully
    if (!(await isRtkAvailable())) {
      console.warn("[rtk] rtk binary not found in PATH — plugin disabled")
      return
    }

    // Hook into tool execution to rewrite bash/shell commands
    await ctx.tool.hook("execute.before", async (event) => {
      const tool = String(event.tool ?? "").toLowerCase()
      if (tool !== "bash" && tool !== "shell") return

      const input = event.input as { command?: unknown } | undefined
      if (!input || typeof input.command !== "string" || !input.command) return

      const rewritten = await rewriteCommand(input.command)
      if (rewritten) {
        input.command = rewritten
      }
    })
  },
})
