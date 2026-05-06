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
}
