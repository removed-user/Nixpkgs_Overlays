# Declare a custom package set

If you require multiple independent package channels?...
You can use _module.args to declare a custom package set,
passing multiple channels into your environment seamlessly

```nix
perSystem = { system, ... }: {
  # Rebind standard pkgs to stable
  _module.args.pkgs = import inputs.nixpkgs-stable { inherit system; };

  # Inject a brand new argument called 'pkgs-unstable'
  _module.args.pkgs-unstable = import inputs.nixpkgs-unstable { inherit system; };
};

# Now you can request both in your modules:
perSystem = { pkgs, pkgs-unstable, ... }: {
  packages.default = pkgs.hello;
  packages.bleeding-edge = pkgs-unstable.neovim;
};
```
