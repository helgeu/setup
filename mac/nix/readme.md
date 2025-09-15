# Mac setup of Nix and Home Manager

## Bootstrap nix

From https://nixos.org/download/#nix-install-macos

```bash
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)
```

Details at: https://nix.dev/manual/nix/2.28/installation/installing-binary#macos-installation

Also added to the file ```bootstrap-nix.sh```

## Make an initial flake.nix

Make sure to edit $USER in the script file.

```nix
# ~/.config/nix/flake.nix

{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
        url = "github:LnL7/nix-darwin";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = {pkgs, ... }: {
        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility. please read the changelog
        # before changing: `darwin-rebuild changelog`.
        system.stateVersion = 5;

        # The platform the configuration will be used on.
        # If you're on an Intel system, replace with "x86_64-darwin"
        nixpkgs.hostPlatform = "aarch64-darwin";

        # Declare the user that will be running `nix-darwin`.
        users.users."$USER" = {
            name = "$USER";
            home = "/Users/$USER";
        };

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true;

        environment.systemPackages = [ ];
    };
  in
  {
    darwinConfigurations."$HOSTNAME" = nix-darwin.lib.darwinSystem {
      modules = [
         configuration
      ];
    };
  };
}
```

After setting up the user section as expected lets run some cmds:

```bash
sudo nix run nix-darwin --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake ~/.config/nix
```

Mind that the paths here needs to align related to the previous created flake.nix etc.

Lets test nix-darwin is installed:

```bash
darwin-rebuild --help
```

## Uninstall or clean up

https://nix.dev/manual/nix/2.28/installation/uninstall#macos

1. Run ```undo-bootstrap-1.sh```
2. Do step 4 from above:
   Edit fstab using ```sudo vifs``` to remove the line mounting the Nix Store volume on /nix, which looks like
```
UUID=<uuid> /nix apfs rw,noauto,nobrowse,suid,owners
```
or
```
LABEL=Nix\040Store /nix apfs rw,nobrowse
```
3. Do step 5 from above link:
Edit /etc/synthetic.conf to remove the nix line. If this is the only line in the file you can remove it entirely:
```
if [ -f /etc/synthetic.conf ]; then
  if [ "$(cat /etc/synthetic.conf)" = "nix" ]; then
    sudo rm /etc/synthetic.conf
  else
    sudo vi /etc/synthetic.conf
  fi
fi
```
4. Run ```undo-bootstrap-2.sh```
