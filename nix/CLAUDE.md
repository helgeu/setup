# Nix Configuration

Nix-specific rules layered on top of the root CLAUDE.md.

## lsp-servers.nix

Single source of truth for LSP server configs — shared by nvf and Claude Code. Changes here affect both.

## Change Strategy

- **Verify side effects** - App configs (VS Code extensions, Brave extensions, etc.) can be wiped by Nix if managed declaratively. Always check what Nix will manage vs what the user manages manually
- **Update todo** - Only mark done after user confirms working

## Special Cases

- **Brave Browser**: Installed via Homebrew (not Nix) for iCloud Passwords compatibility
- **Ghostty**: Installed via Homebrew (not Nix) - nixpkgs only supports Linux
- **macOS-only packages**: `xcodegen`, `alt-tab-macos`, `iterm2`, `ghostty`
- **Config paths**: macOS uses `Library/Application Support/`, Linux uses `.config/`

## VS Code Extension Dependencies

When adding VS Code extensions, check for dependencies using:
```bash
jq '.extensionDependencies' ~/.vscode/extensions/<ext>/package.json
```

Known dependencies (must be added explicitly in Nix):
- `42crunch.vscode-openapi` → `redhat.vscode-yaml`
- `ms-dotnettools.csdevkit` → `ms-dotnettools.csharp`, `ms-dotnettools.vscode-dotnet-runtime`
- `ms-dotnettools.csharp` → `ms-dotnettools.vscode-dotnet-runtime`
