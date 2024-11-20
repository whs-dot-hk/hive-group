{
  inputs.lib.url = "github:nix-community/nixpkgs.lib";
  outputs = {
    lib,
    self,
  }: {
    group = import ./group.nix {inherit lib;};
  };
}
