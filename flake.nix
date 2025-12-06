{
  description = "My nixos configuration.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    stylix.url = "github:danth/stylix";
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    determinate,
    stylix,
    ...
  }: {
    nixosConfigurations.wonderland = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
        determinate.nixosModules.default
        stylix.nixosModules.stylix
      ];
    };
  };
}
