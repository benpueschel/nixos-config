# nixos-config
My [NixOS](https://nixos.org/) development environment

## Build
If you don't already have a NixOS installation follow the [installation guide](https://nixos.org/manual/nixos/stable/#ch-installation). If you have a running NixOS installation, clone the git repository to `/etc/nixos`. 
Then run 
```sh
nixos-generate-config
```
This will generate your specialized hardware-configuration.nix file. To apply the configuration, run 
```sh
nixos-rebuild switch
```
and reboot your system.
