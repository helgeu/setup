import { Plugin } from "@opencode/plugin/tui"

// Smart punctuation for the opencode prompt: macOS/iOS-style "double-space ->
// period". Typing two spaces after a word inserts ". " instead of "  ".
// Pressing Backspace immediately after reverts it to two spaces.
//
// OpenCode V2 does not expose keymap.intercept to plugins. A keymap layer with
// a higher priority than the prompt's textarea layer binds space and backspace
// instead. A command that returns false lets the key continue to the textarea.
// All buffer changes use the public EditBuffer API on the focused editor
// (renderer.currentFocusedEditor).
//
// Context-gated (no keystroke timing), like Apple's text substitution.

export default Plugin.define({
  id: "local.smart-punctuation",
  setup(context) {
    // Cursor offset at which an auto-inserted ". " can still be reverted by an
    // immediately-following backspace. -1 means nothing is pending.
    let revertOffset = -1

    const editor = () => {
      const e = context.renderer.currentFocusedEditor
      if (!e || e.isDestroyed || e.hasSelection()) return undefined
      return e
    }

    context.keymap.layer(() => ({
      mode: "global",
      priority: 100,
      commands: [
        {
          id: "local.smart-punctuation.space",
          bind: "space",
          run: () => {
            revertOffset = -1
            const e = editor()
            if (!e) return false
            const offset = e.logicalCursor.offset
            if (offset < 2) return false
            // UTF-8 is self-synchronizing, so a fixed-size trailing window
            // decodes its last characters correctly.
            const before = e.getTextRange(Math.max(0, offset - 16), offset)
            if (before.length < 2) return false
            if (before[before.length - 1] !== " ") return false
            if (!/[\p{L}\p{N}]/u.test(before[before.length - 2])) return false
            e.deleteCharBackward()
            e.insertText(". ")
            revertOffset = e.logicalCursor.offset
          },
        },
        {
          id: "local.smart-punctuation.backspace",
          bind: "backspace",
          run: () => {
            const pending = revertOffset
            revertOffset = -1
            const e = editor()
            if (!e || pending < 0 || e.logicalCursor.offset !== pending) return false
            e.deleteCharBackward()
            e.deleteCharBackward()
            e.insertText("  ")
          },
        },
      ],
      bindings: ["local.smart-punctuation.space", "local.smart-punctuation.backspace"],
    }))
  },
})