{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./boot-config.nix
    ./gnome-config.nix
    ./hyprland-config.nix
  ];

  # Stylix
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  stylix.image = ./assets/wallpaper;

  # Automatic cleaning
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Networking
  networking.hostName = "wonderland"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Graphics
  hardware.graphics.enable = true;
  hardware.intel-gpu-tools.enable = true;
  hardware.graphics.extraPackages = with pkgs; [intel-media-driver intel-ocl intel-vaapi-driver];
  hardware.cpu.intel.updateMicrocode = true;
  hardware.graphics.package = pkgs.mesa;

  hardware.firmwareCompression = "zstd";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Fonts
  fonts.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  # Sound
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  # Enabled bluetooth
  hardware.bluetooth.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.raph = {
    createHome = false;
    extraGroups = ["wheel" "docker" "kvm" "networkmanager"]; # Enable ‘sudo’ for the user.
    hashedPasswordFile = "./hashed-password";
    isNormalUser = true;
    shell = pkgs.fish;
    uid = 1000;
  };

  programs.fish.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Virtualisztion
  virtualisation.podman = {
    enable = true;
    dockerSocket.enable = true;
  };

  environment.systemPackages = [
    pkgs.atuin
    pkgs.bat
    pkgs.binutils
    pkgs.carapace
    pkgs.clang
    pkgs.curl
    pkgs.docker-compose
    pkgs.eza
    pkgs.ffmpeg
    pkgs.fzf
    pkgs.gcc
    pkgs.ghostty
    pkgs.gitFull
    pkgs.gzip
    pkgs.kitty
    pkgs.lazydocker
    pkgs.lazygit
    pkgs.lm_sensors
    pkgs.neovim
    pkgs.nushell
    pkgs.podman-compose
    pkgs.ripgrep
    pkgs.ssh-tools
    pkgs.starship
    pkgs.tldr
    pkgs.unzip
    pkgs.vim
    pkgs.vlc
    pkgs.wget
    pkgs.xz
    pkgs.zig
    pkgs.zip
    pkgs.zls
    pkgs.zoxide
    pkgs.zstd
  ];

  programs.mtr.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  networking.firewall.enable = false;

  system.stateVersion = "25.11";
}
