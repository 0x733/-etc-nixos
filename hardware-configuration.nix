{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/8b4fd7e4-3553-4569-828e-23c26b91a79f";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/BA19-A1A7";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
  };

  boot.initrd.luks.devices."luks-adaa8a8e-e6c4-4301-81b3-0258d470a191".device = "/dev/disk/by-uuid/adaa8a8e-e6c4-4301-81b3-0258d470a191";

  swapDevices = [
    { device = "/dev/disk/by-uuid/39fe2f18-ee0c-4dbb-93d5-65fa570911ed"; }
  ];

  networking = {
    useDHCP = lib.mkDefault true;
    # interfaces.enp2s0.useDHCP = lib.mkDefault true;
  };

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
  };

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}