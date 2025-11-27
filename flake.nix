{
  description = "My nixos configuration.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-25.05";
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: {
    nixosConfigurations.wonderland = nixpkgs.lib.nixosSystem {
      modules = [./configuration.nix];
    };
  };
}
