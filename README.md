# Using `_module.args`

Instead of passing your overlays down to individual package definitions manually... 
setting _module.args.pkgs applies your overlays globally across the entire flake architecture.

```nix
perSystem = { system, ... }: {
  _module.args.pkgs = import inputs.nixpkgs {
    inherit system;
    overlays = [
      inputs.rust-overlay.overlays.default  # External community overlay
      (final: prev: { my-app = prev.hello; }) # Custom inline overlay
    ];
  };
}
```

Any subsequent code block in that system block that asks for 
`{ pkgs, ... }`
automatically receives the fully overlaid package set.

## Enabling Global Configuration Flags

By overriding the base package initialization... 
you can enable global behavior parameters—
like allowing unfree packages or broken builds—
for all derivations in your environment at once.

```nix
_module.args.pkgs = import inputs.nixpkgs {
  inherit system;
  config = {
    allowUnfree = true;
    allowBroken = false;
    cudaSupport = true; # Compiles supporting packages with CUDA enabled
  };
};
```
