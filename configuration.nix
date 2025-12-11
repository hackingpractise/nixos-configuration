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
  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    image = ./assets/wallpaper.png;
    polarity = "dark";
    cursor = {
      name = "Bibata-Mordern-Amber";
      package = pkgs.bibata-cursors;
      size = 20;
    };
    targets = {
      gnome = {
        enable = true;
      };
      gtk.enable = true;
    };
  };

  # Automatic cleaning
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 10d";
  };

  # Networking
  networking = {
    hostName = "wonderland"; # Define your hostname.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
    firewall.enable = false;
  };

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Graphics
  hardware.graphics.enable = true;
  hardware.intel-gpu-tools.enable = true;
  hardware.cpu.intel.updateMicrocode = true;
  # hardware.graphics.extraPackages = with pkgs; [intel-media-driver intel-ocl intel-vaapi-driver];
  # hardware.graphics.package = pkgs.mesa;

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
    extraGroups = ["wheel" "docker" "podman" "kvm" "networkmanager"]; # Enable ‘sudo’ for the user.
    hashedPasswordFile = "./hashed-password";
    isNormalUser = true;
    shell = pkgs.fish;
    uid = 1000;
  };

  programs.mtr.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.fish.enable = true;

  # Libraries
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      gtk3
      openssl
      sqlite
      pkg-config
      stdenv.cc.cc # Standard C++ libraries
      zeromq
      zlib
    ];
  };

  services.envfs.enable = true;

  # Virtualisztion
  virtualisation.podman = {
    enable = true;
    dockerSocket.enable = false;
  };
  virtualisation.docker = {
    enable = true;
  };
  nixpkgs.config.allowUnfree = true;

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
    pkgs.gitFull
    pkgs.gzip
    pkgs.kitty
    pkgs.lazydocker
    pkgs.lazygit
    pkgs.lm_sensors
    pkgs.neovim
    pkgs.nushell
    pkgs.pkg-config
    pkgs.podman-compose
    pkgs.procs
    pkgs.ripgrep
    pkgs.sqlite
    pkgs.ssh-tools
    pkgs.starship
    pkgs.tldr
    pkgs.unzip
    pkgs.vim
    pkgs.vlc
    pkgs.wget
    pkgs.wl-clipboard
    pkgs.xz
    pkgs.zig
    pkgs.zip
    pkgs.zls
    pkgs.zoxide
    pkgs.zstd
  ];

  system.stateVersion = "25.11";
}
