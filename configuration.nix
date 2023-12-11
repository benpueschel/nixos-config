# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure X11
  services.xserver = {
    enable = true;
    layout = "us";
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
      ];
    };
    displayManager = {
      sddm.enable = true;
      autoLogin = {
        enable = false;
        user = "ben";
      };
    };
  };

  users.users.ben = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "sudo" "audio" ];
    packages = with pkgs; [
      neovim
      firefox-devedition
      alacritty
      spotify
    ];
    shell = pkgs.zsh;
  };

  environment.variables = {
    TERMINAL = "alacritty"; # set i3wm default terminal
  };

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
  };

  programs.zsh.enable = true;

  # enable openssh daemon to start ssh server
  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    # default programs
    vim
    git
    zsh
    tmux

    # system utilities
    gnumake
    gnugrep
    gnupg
    ripgrep
    curl
    wget
    gnutar
    zip
    unzip
    xclip
    openssl
    clang
    gcc
    rustup

    # gui
    i3
    xorg.libX11
    xorg.libX11.dev
    xorg.libxcb
    xorg.libXft
    xorg.libXinerama
    xorg.xinit
    xorg.xinput
  ];

  fonts = {
    packages = with pkgs; [
      font-awesome
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) # only install JetBrainsMono, not every single nerd font
    ];
    enableDefaultPackages = true;
    fontconfig = {
      defaultFonts = {
        monospace = [ "JetBrainsMonoNL Nerd Font" ];
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
