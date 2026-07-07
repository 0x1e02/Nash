{
  description = "Nash -- Home NAS and Lab System";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    impermanence.url = "github:nix-community/impermanence";
    disko.url = "github:nix-community/disko";
  };

  outputs = { self, nixpkgs, disko, impermanence, ... }: {
    nixosConfigurations.nash = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        disko.nixosModules.disko
        impermanence.nixosModules.impermanence
        ./hosts/nash/configuration.nix
        ./hosts/nash/hardware-configuration.nix
        ./hosts/nash/disko.nix
        ./modules/nfs.nix
      ];
    };
  };
}
