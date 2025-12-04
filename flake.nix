{
  description = "My nixos configuration.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-25.11";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    determinate,
    ...
  }: {
    nixosConfigurations.wonderland = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
        determinate.nixosModules.default
      ];
    };
  };
}
