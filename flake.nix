{
  inputs.POP.url = "github:divnix/POP/visibility";
  inputs.lib.url = "github:nix-community/nixpkgs.lib";

  outputs = {
    POP,
    lib,
    self,
  }: {
    group = import ./group.nix {
      inherit POP;
      inherit lib;
    };
  };
}
