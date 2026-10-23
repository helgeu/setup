{
  config,
  pkgs,
  ...
}:
{
  home.file."githooks/pre-commit" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -e

      FAILED=0

      # Get staged files (added, copied, modified — not deleted)
      STAGED=$(git diff --cached --name-only --diff-filter=ACM)

      # nixfmt check on staged .nix files
      NIX_FILES=$(echo "$STAGED" | grep '\.nix$' || true)
      if [ -n "$NIX_FILES" ]; then
        echo "→ nixfmt"
        if ! echo "$NIX_FILES" | xargs ${pkgs.nixfmt}/bin/nixfmt --check; then
          echo "  Fix: run 'nixfmt <file>' and re-stage"
          FAILED=1
        fi
      fi

      # shellcheck on staged bash scripts (.sh, .bash, and extensionless nix/bin/*)
      SHELL_FILES=$(echo "$STAGED" | grep -E '(\.sh|\.bash|^nix/bin/[^/.]+)$' || true)
      if [ -n "$SHELL_FILES" ]; then
        echo "→ shellcheck"
        if ! echo "$SHELL_FILES" | xargs ${pkgs.shellcheck}/bin/shellcheck --shell=bash --severity=warning; then
          echo "  Fix: address shellcheck warnings and re-stage"
          FAILED=1
        fi
      fi

      # gitleaks secret scanning
      echo "→ gitleaks"
      if ! ${pkgs.gitleaks}/bin/gitleaks protect --staged --no-banner; then
        echo "  Secrets detected in staged changes. Commit blocked."
        FAILED=1
      fi

      if [ $FAILED -ne 0 ]; then
        echo ""
        echo "❌ Pre-commit checks failed. Fix issues above and re-stage."
        exit 1
      fi

      echo "✓ All checks passed"
    '';
  };

  home.file.".config/git/ignore".text = ''
    # Nix build outputs
    result
    result-*
  '';

  programs = {
    git = {
      enable = true;
      signing.format = null;
      package =
        if pkgs.stdenv.hostPlatform.isDarwin then
          pkgs.git.override { osxkeychainSupport = false; }
        else
          pkgs.git;
      settings = {
        user.email = "helge@urholm.no";
        user.name = "helgereneurholm";

        credential.helper = "manager";
        credential.useHttpPath = true;
        # Always authenticate via the web browser (OAuth popup) — never device
        # code, PAT or terminal. GitHub honours this explicitly; Azure DevOps
        # already uses the Microsoft browser flow by default.
        credential.gitHubAuthModes = "browser";
        core = {
          commentChar = ";";
          hooksPath = "${config.home.homeDirectory}/githooks";
          pager = "delta";
        };
        push = {
          default = "current";
          autoSetupRemote = true;
        };
        pull = {
          rebase = true;
        };
        rebase = {
          autosquash = true;
        };
        diff = {
          algorithm = "histogram";
          colorMoved = "plain";
          renames = true;
        };
        help = {
          autocorrect = "prompt";
        };
        fetch = {
          prune = true;
          pruneTags = true;
        };
        blame = {
          ignoreRevsFile = ".git-blame-ignore-revs";
        };
        merge = {
          conflictStyle = "zdiff3";
        };
        rerere = {
          enabled = true;
          autoUpdate = true;
        };
        tag = {
          sort = "-version:refname";
        };
      };
    };
  };
}
