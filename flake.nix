{
  description = "My nixos configuration.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    nixpkgsOld.url = "github:NixOS/nixpkgs?ref=nixos-25.05";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    stylix.url = "github:danth/stylix";
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    determinate,
    stylix,
    nixpkgsOld,
    ...
  }: let
    system = "x86_64-linux";
    pkgsOld = import nixpkgsOld {inherit system;};
  in {
    nixosConfigurations.wonderland = nixpkgs.lib.nixosSystem {
      modules = [
        {environment.systemPackages = [pkgsOld.ghostty];}
        ./configuration.nix
        determinate.nixosModules.default
        stylix.nixosModules.stylix
      ];
    };
  };
}
