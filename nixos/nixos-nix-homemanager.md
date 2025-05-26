# 🌐 Nixos, nix, home manager

General setup for nix and home manager

## 🖥️ Nixos on WSL

### 🛠️ Install Nixos

[Nixos|WSL](https://nix-community.github.io/NixOS-WSL/)

See [installation](https://nix-community.github.io/NixOS-WSL/install.html).

#### 📥 Download nixos.wls

```powershell
mkdir c:\temp\nixos\
iwr https://github.com/nix-community/NixOS-WSL/releases/download/2411.6.0/nixos.wsl -outfile c:\temp\nixos\nixos.wsl
```

#### ⚙️ Setup Nixos

```powershell
wsl --install --from-file c:\temp\nixos\nixos.wsl
```

#### 🚀 Start Nixos

```powershell
wsl -d Nixos
```

#### 🔄 Update Nixos

```bash
sudo nix-channel --update
sudo nixos-rebuild switch
```

#### 💣 Nuke Nixos

```powershell
wsl --unregister Nixos
```

## 🏠 Home manager on Nixos (in WSL)

Now we have some variant of a Nixos in WSL and can start setting up the different configs.

It can be some different files here and there but use some easy startup.

This is a temporary variant to get things going after config files are created/added in place to have home-manager available.


```bash
export NIX_CONFIG="experimental-features = nix-command flakes"
nix shell nixpkgs#home-manager
```

If having some repo of files wanting to be used then do:

```bash
git clone https://github.com/helgeu/setup.git
```
Go to folder containing relevant setup, with the above repo in ```./setup/nixos/hm```, and now we can build the setup with the given config files:

```bash
sudo nixos-rebuild switch --flake .#nixos
```

And then the home manager can be built. For each change just repeat this command.

```bash
home-manager switch --flake .#nixos@nixos
```

At this point starting a new terminal and logging back in will show the actual new prompt (oh-my-posh setup) and all configured programs should be working.

## Neovim setup

A pretty much basic setup for lazyvim is "included". To use this one, use the script:

```bash
linuxmakesymlink4neovim.sh
```

and it will create a symlink with basic setup.

Then start nvim and it will initialize, install and update on its own.
