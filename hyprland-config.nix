{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };
  environment.systemPackages = [
    pkgs.aquamarine
    pkgs.brightnessctl
    pkgs.hyprcursor
    pkgs.hyprgraphics
    pkgs.hypridle
    pkgs.hyprland-protocols
    pkgs.hyprlang
    pkgs.hyprlock
    pkgs.hyprpaper
    pkgs.hyprsunset
    pkgs.hyprutils
    pkgs.hyprwayland-scanner
    pkgs.kdePackages.kdeconnect-kde
    pkgs.rofi
    pkgs.waybar
  ];
}
