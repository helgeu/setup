{
  config,
  lib,
  pkgs,
  ...
}:
let
  # The upstream RTK HM module generates the OpenCode plugin, but currently
  # only installs Claude files. Source the generated plugin explicitly.
  rtkOpenCodePlugin =
    pkgs.runCommand "rtk-opencode-plugin.ts"
      {
        nativeBuildInputs = [
          config.programs.rtk.package
          pkgs.jq
        ];
      }
      ''
        ${lib.getExe config.programs.rtk.package} init --dry-run --json --opencode > manifest.json
        jq -e -j '.files[] | select(.path == ".config/opencode/plugins/rtk.ts") | .content' manifest.json > "$out"
      '';
in
{
  programs.rtk.opencode.enable = true;

  # Global rules for OpenCode. Same canonical, tool-neutral source that Claude
  # Code gets as ~/.claude/CLAUDE.md (see ../shared.nix baseClaude). Emitting it
  # explicitly as AGENTS.md means we no longer rely on OpenCode's implicit
  # ~/.claude/CLAUDE.md fallback (which a future AGENTS.md would silently shadow).
  home.file.".config/opencode/AGENTS.md".source = ../shared/global-rules.md;

  # Task→script map for the custom helper tools (see ../shared/scripts-reference.md).
  # Symlinked for both tools; global-rules.md points at the ~/.claude/ copy.
  home.file.".config/opencode/scripts-reference.md".source = ../shared/scripts-reference.md;

  home.file.".config/opencode/plugins/rtk.ts".source = rtkOpenCodePlugin;

  # Headless PR-review agent (scoped permissions). Used by the `pr-review`
  # script together with the ~/.claude/skills/pr-review skill.
  home.file.".config/opencode/agent/pr-review.md".source = ./agents/pr-review.md;

  # Headless spike fact-finder agent (scoped permissions: question disabled,
  # ADO read-only, no push/commit). Used by the `spike-factfind` script to
  # investigate a work item at origin/main and emit a findings draft plus an
  # evidence-backed question list for a human interview.
  home.file.".config/opencode/agent/spike.md".source = ./agents/spike.md;

  # OpenCode config, incl. a local Ollama provider (OpenAI-compatible endpoint).
  # Model keys MUST match the exact `ollama list` names so `opencode --model
  # ollama/<key>` resolves. Launch via the `oc` helper script (see ../../bin).
  home.file.".config/opencode/opencode.jsonc".text = builtins.toJSON {
    "$schema" = "https://opencode.ai/config.json";
    # External-directory allowlist. Only applies to paths OUTSIDE the current
    # workspace root (e.g. when cwd is a project like ~/ado/<repo> and the agent
    # needs a sibling repo, ~/.claude configs, or a temp file). Fall back to
    # "ask" (never a silent hard "deny"), and pre-approve the trees actually
    # worked in so they don't prompt. Anything else prompts for permission
    # instead of failing outright. NOTE: opencode uses LAST-match-wins and
    # builtins.toJSON sorts keys, so "*" (ask) sorts before every "/…"/"~…"
    # allow — giving the broad fallback first and the specific allows last, as
    # required. Keep every allow pattern starting with "/" or "~".
    permission.external_directory = {
      "*" = "ask";
      "~/ado/**" = "allow";
      "~/git/**" = "allow";
      "~/.claude/**" = "allow";
      "~/.config/opencode/**" = "allow";
      "/var/folders/**" = "allow";
      "/tmp/**" = "allow";
      "/nix/store/**" = "allow";
    };
    provider.ollama = {
      npm = "@ai-sdk/openai-compatible";
      name = "Ollama (local)";
      options.baseURL = "http://localhost:11434/v1";
      models = {
        "qwen3.6:latest".name = "Qwen3.6 (local)";
        "qwen3-coder:30b".name = "Qwen3 Coder 30B (local)";
        "muse-glimmer:latest".name = "Muse Glimmer (local)";
      };
    };
  };
}
