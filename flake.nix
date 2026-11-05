{
  description = "NixOS configuration";

  inputs = {
    # Pinned to the revision the current system was built from
    # (26.05.6503.21ea275a7c46). Swap for
    # "github:NixOS/nixpkgs/nixos-26.05" to track stable, or update later
    # with `nix flake update`.
    nixpkgs.url = "github:NixOS/nixpkgs/21ea275a7c46aef9d4d6ddc962e6d562e9d94183";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          {
            nixpkgs.overlays = [
              (final: prev:
                let
                  unstable = import nixpkgs-unstable {
                    inherit (prev.stdenv.hostPlatform) system;
                    config = prev.config;
                  };
                in
                {
                  inherit unstable;
                  # Unstable Discord (1.0.168) fixes the H.264/error 2012
                  # decoder bug. Remove this line to keep stable Discord.
                  discord = unstable.discord;
                })
            ];
          }
        ];
      };
    };
}
