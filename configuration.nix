{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    initrd.luks.devices."luks-170e091d-c709-4958-96b4-a2f4687b6b99".device = "/dev/disk/by-uuid/170e091d-c709-4958-96b4-a2f4687b6b99";
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  };

  time = {
    timeZone = "Europe/Istanbul";
  };

  i18n = {
    defaultLocale = "tr_TR.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "tr_TR.UTF-8";
      LC_IDENTIFICATION = "tr_TR.UTF-8";
      LC_MEASUREMENT = "tr_TR.UTF-8";
      LC_MONETARY = "tr_TR.UTF-8";
      LC_NAME = "tr_TR.UTF-8";
      LC_NUMERIC = "tr_TR.UTF-8";
      LC_PAPER = "tr_TR.UTF-8";
      LC_TELEPHONE = "tr_TR.UTF-8";
      LC_TIME = "tr_TR.UTF-8";
    };
  };

  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "tr";
        variant = "";
      };
    };
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    printing.enable = false;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };

  users = {
    users.user = {
      isNormalUser = true;
      description = "user";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
        kdePackages.kate
      ];
      shell = pkgs.zsh;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      brave
      eza
      ferdium
      git
      mullvad-browser
      nix-zsh-completions
      python3
      python3Packages.requests
      tor-browser
      vim
      wget
      zsh
      zsh-autocomplete
      zsh-autosuggestions
      zsh-syntax-highlighting
    ];
  };

  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      zsh-autoenv.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      ohMyZsh = {
        enable = true;
        theme = "bira";
        plugins = [ "git" "sudo" "web-search" "python" "pip" "history-substring-search" "colored-man-pages" ];
      };
    };
    kdeconnect.enable = true;
  };

  system = {
    autoUpgrade = {
      enable = true;
      allowReboot = true;
    };
    stateVersion = "24.05";
  };

  nixpkgs.config.allowUnfree = true;
}