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
    pkgs.hyprlock
    pkgs.hypridle
    pkgs.hyprpaper
    pkgs.hyprsunset
    pkgs.rofi
    pkgs.waybar
  ];
}
