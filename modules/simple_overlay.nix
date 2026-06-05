# modules/simple_overlay.nix
{ self, inputs, ... }:

{
  # 1. Export the overlay globally so other flakes can use it
  flake.overlays.default = final: prev: {
    # Put your package modifications or grsec-stdenv tweaks here
    my-custom-package = prev.callPackage ../pkgs/my-custom-package.nix { };
  };

  # 2. Apply it locally to the 'pkgs' instance inside flake-parts
  perSystem = { system, ... }: {
    # This configures the nixpkgs instance passed to perSystem arguments
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      # Safely inject your exported overlay
      overlays = [ self.overlays.default ]; 
      config = {
        allowUnfree = true;
      };
    };
  };
}
