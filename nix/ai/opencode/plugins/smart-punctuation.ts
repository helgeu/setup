import type { TuiPlugin, TuiPluginModule } from "@opencode-ai/plugin/tui"

// Smart punctuation for the opencode prompt: macOS/iOS-style "double-space ->
// period". Typing two spaces after a word inserts ". " instead of "  ";
// pressing Backspace immediately after reverts it to two spaces.
//
// This is the maintainer-endorsed DOWNSTREAM approach (no opentui/opencode core
// change): opencode routes prompt typing through its keymap
// (registerManagedTextareaLayer), so a key intercept that calls consume() runs
// before the textarea inserts the space. All buffer mutation uses the public
// EditBuffer API on the focused editor (renderer.currentFocusedEditor).
//
// Context-gated (no keystroke timing), matching Apple + editor input-rule
// systems. Auto-loaded because it lives in ~/.config/opencode/plugins/.

const id = "local:smart-punctuation"

const tui: TuiPlugin = async (api) => {
  // Offset the cursor must still be at for an auto-inserted ". " to be
  // revertible by an immediately-following backspace. -1 means nothing pending.
  let revertOffset = -1

  const off = api.keymap.intercept(
    "key",
    (ctx) => {
      const e = ctx.event
      if (e.ctrl || e.meta || e.super || e.hyper) return

      const editor = api.renderer.currentFocusedEditor
      if (!editor || editor.isDestroyed) return
      if (editor.hasSelection()) {
        revertOffset = -1
        return
      }

      // Every keypress consumes the chance to revert a previous auto-period, so
      // only the immediately-following backspace can trigger the revert.
      const pending = revertOffset
      revertOffset = -1

      // Revert-on-immediate-backspace: undo the ". ", restoring two spaces.
      if (pending >= 0 && e.name === "backspace" && editor.logicalCursor.offset === pending) {
        editor.deleteCharBackward()
        editor.deleteCharBackward()
        editor.insertText("  ")
        ctx.consume()
        return
      }

      // Convert only on a space typed right after "<letter|digit><space>".
      if (e.name !== "space") return
      const offset = editor.logicalCursor.offset
      if (offset < 2) return
      // UTF-8 is self-synchronizing, so a fixed-size trailing window decodes its
      // last characters correctly even if it starts mid-codepoint.
      const before = editor.getTextRange(Math.max(0, offset - 16), offset)
      if (before.length < 2) return
      if (before[before.length - 1] !== " ") return
      if (!/[\p{L}\p{N}]/u.test(before[before.length - 2])) return

      editor.deleteCharBackward()
      editor.insertText(". ")
      revertOffset = editor.logicalCursor.offset
      ctx.consume()
    },
    { priority: 1 },
  )

  api.lifecycle.onDispose(off)
}

const plugin: TuiPluginModule = { id, tui }

export default plugin
