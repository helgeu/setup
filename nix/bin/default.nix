# User scripts installed into ~/bin on every machine.
#
# To add a new personal script: drop the file in this directory and add a
# matching `home.file."bin/<name>"` entry below. Everything here is symlinked
# into ~/bin (read-only) and ~/bin is put on PATH for all hosts.
{ ... }:
{
  home.file = {
    "bin/ado-approve-deploy" = {
      source = ./ado-approve-deploy;
      executable = true;
    };
    "bin/ado-create-tasks" = {
      source = ./ado-create-tasks;
      executable = true;
    };
    "bin/ado-deploy-metrics" = {
      source = ./ado-deploy-metrics;
      executable = true;
    };
    "bin/ado-dora" = {
      source = ./ado-dora;
      executable = true;
    };
    "bin/ado-dora-chart" = {
      source = ./ado-dora-chart;
      executable = true;
    };
    "bin/ado-my-items" = {
      source = ./ado-my-items;
      executable = true;
    };
    "bin/ado-prs-chart" = {
      source = ./ado-prs-chart;
      executable = true;
    };
    "bin/ado-prs-export" = {
      source = ./ado-prs-export;
      executable = true;
    };
    "bin/azprs" = {
      source = ./azprs;
      executable = true;
    };
    "bin/copilot-usage" = {
      source = ./copilot-usage;
      executable = true;
    };
    "bin/find-prs" = {
      source = ./find-prs;
      executable = true;
    };
    "bin/oc" = {
      source = ./oc;
      executable = true;
    };
    "bin/outlook-draft" = {
      source = ./outlook-draft;
      executable = true;
    };
    "bin/outlook-meeting" = {
      source = ./outlook-meeting;
      executable = true;
    };
    "bin/opencode-cost" = {
      source = ./opencode-cost;
      executable = true;
    };
    "bin/opencode-fix-message-ids" = {
      source = ./opencode-fix-message-ids;
      executable = true;
    };
    "bin/pr-model-select" = {
      source = ./pr-model-select;
      executable = true;
    };
    "bin/pr-review" = {
      source = ./pr-review;
      executable = true;
    };
    "bin/pr-review-post" = {
      source = ./pr-review-post;
      executable = true;
    };
    "bin/sonar-scan" = {
      source = ./sonar-scan;
      executable = true;
    };
    "bin/spike-attach" = {
      source = ./spike-attach;
      executable = true;
    };
    "bin/spike-factfind" = {
      source = ./spike-factfind;
      executable = true;
    };
    "bin/standup" = {
      source = ./standup;
      executable = true;
    };
  };

  # Ensure ~/bin is on PATH everywhere.
  home.sessionPath = [ "$HOME/bin" ];
}
