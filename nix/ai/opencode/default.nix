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

  home.file.".config/opencode/plugins/rtk.ts".source = rtkOpenCodePlugin;

  # Headless PR-review agent (scoped permissions). Used by the `pr-review`
  # script together with the ~/.claude/skills/pr-review skill.
  home.file.".config/opencode/agent/pr-review.md".source = ./agents/pr-review.md;

  # OpenCode config, incl. a local Ollama provider (OpenAI-compatible endpoint).
  # Model keys MUST match the exact `ollama list` names so `opencode --model
  # ollama/<key>` resolves. Launch via the `oc` helper script (see ../../bin).
  home.file.".config/opencode/opencode.jsonc".text = builtins.toJSON {
    "$schema" = "https://opencode.ai/config.json";
    provider.ollama = {
      npm = "@ai-sdk/openai-compatible";
      name = "Ollama (local)";
      options.baseURL = "http://localhost:11434/v1";
      models = {
        "qwen3.6:latest".name = "Qwen3.6 (local)";
        "qwen3-coder:30b".name = "Qwen3 Coder 30B (local)";
      };
    };
  };
}
