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
  TBD
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


nvim --headless +':checkhealth' +':w! health_report.log' +':qa!'