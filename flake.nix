{
  description = "NixOS N64 emulation module";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    nixosModules.n64 = import ./n64.nix;
  };
}
