{ pkgs, lib, config, ... }:
let
  lspServers = import ../../lsp-servers.nix { inherit pkgs; };
  home = config.home.homeDirectory;

  # Azure DevOps targets. nix generates ~/.claude/ado/configs/<org>-<project>.json
  # from each entry below. To add a target, append an entry and rebuild.
  # Schema is documented in ./ado-cli-reference.md.
  adoConfigs = [
    {
      org = "urholm";
      organizationUrl = "https://dev.azure.com/urholm";
      project = "Devkunt";
      process = "Devkunt Agile";
      processBase = "Agile";
      azureConfigDir = "${home}/git/urholm/.az";
      repositories = [ "devkunt-backend" "devkunt-frontend" "Devkunt.wiki" ];
      workItemTypes = [ "Epic" "Feature" "User Story" "Task" "Bug" ];
      notes = "Agility event platform; backend/frontend consolidating to a monorepo.";
    }
    # Add more orgs/projects here.
  ];

  adoConfigFiles = builtins.listToAttrs (map
    (c: lib.nameValuePair ".claude/ado/configs/${c.org}-${c.project}.json"
      { text = builtins.toJSON c; })
    adoConfigs);
in {
  programs.rtk.claudeCode = {
    enable = true;
    baseSettings = ./settings.json;
  };

  home.file = {
    ".claude/.lsp.json".source = lspServers.claudeLspJson;
    ".claude/statusline-command.sh".source = ./statusline-command.sh;
    ".claude/ado-cli-reference.md".source = ./ado-cli-reference.md;
  } // adoConfigFiles;
}
