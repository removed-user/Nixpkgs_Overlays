# flake.nix
{
  description = "A flake-parts setup with a reusable overlay module";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" ];

      # Import your reusable overlay module here
      imports = [
        ./modules/my-overlay.nix
      ];

      perSystem = { config, pkgs, ... }: {
        # 'pkgs' here now automatically includes your overlay modifications!
        packages.default = pkgs.my-custom-package;

        devShells.default = pkgs.mkShell {
          inputsFrom = [ config.packages.default ];
        };
      };
    };
}
