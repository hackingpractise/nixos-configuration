{
  description = "My nixos configuration.";
  inputs = {
    # nixpkgsOld.url = "github:NixOS/nixpkgs?ref=nixos-25.05";
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-25.11";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    stylix.url = "github:danth/stylix";
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    determinate,
    stylix,
    # nixpkgsOld,
    ...
  }: {
    nixosConfigurations.wonderland = nixpkgs.lib.nixosSystem {
      # inherit nixpkgsOld;
      modules = [
        ./configuration.nix
        determinate.nixosModules.default
        stylix.nixosModules.stylix
      ];
    };
  };
}
