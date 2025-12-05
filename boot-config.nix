{
  config,
  pkgs,
  lib,
  ...
}: {
  # grub loader config.
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    enableCryptodisk = true;
  };

  boot.loader.efi.canTouchEfiVariables = true;

  # Disabled systemd-boot
  boot.loader.systemd-boot.enable = false;

  # initrd config.
  boot.initrd = {
    services.lvm.enable = true;
    systemd.enable = true;
    availableKernelModules = [
      "aesni_intel"
      "cryptd"
    ];
  };

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # LUKS configuration
  boot.initrd.luks.devices = {
    luksroot = {
      device = "/dev/disk/by-uuid/cb6fc551-fd3a-4e5d-a6d4-ead8d0e76836";
      keyFileSize = 4096;
      keyFile = "/dev/sdb";
    };
  };
}
