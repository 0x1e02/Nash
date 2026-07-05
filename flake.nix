{
  description = "Nash -- Home NAS and Lab System";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, disko, ... }: {
    nixosConfigurations.nash = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        disko.nixosModules.disko
        ./hosts/nash/configuration.nix
        ./hosts/nas/hardware-configuration.nix
        ./hosts/nash/disko.nix
      ];
    };
  };
}
