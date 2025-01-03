{
  description = "A fork of the serde_tuple crate using explicit traits to de/serialize structs.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.rust-analyzer-src.follows = "";
    };
  };

  outputs = { nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      toolchain = inputs.fenix.packages.${system}.stable.withComponents [
        "cargo"
        "rustc"
        "rust-src"
        "clippy"
        "rustfmt"
      ];
    in {
      devShells.${system}.default = nixpkgs.legacyPackages.${system}.mkShell {
        name = "serde_tuple_explicit";
        buildInputs = [ toolchain ];

        shellHook = ''
          if [ -d .direnv/ ]; then
            rm -rf .direnv/links
            mkdir -p .direnv/links/
            ln -sf "${toolchain}" .direnv/links/rust
          fi
        '';
      };
    };
}
