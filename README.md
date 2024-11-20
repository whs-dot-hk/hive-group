# Example: banana
```nix
# comb/banana/groups.nix
with inputs.cells.lib.helpers; {
  philippines = group.new {
    groupName = "philippines";
    prefix = "banana-";
    ips = [
      "10.0.10.1"
      "10.0.10.2"
      "10.0.10.3"
      "10.0.10.4"
    ];
  };
}


# comb/banana/colmenaConfigurations.nix
{
  inputs,
  cell,
  ...
} @ a:
{}
// (cell.groups.philippines.colmenaConfigurations a)


# comb/banana/diskoConfigurations.nix
{
  inputs,
  cell,
  ...
} @ a:
{}
// (cell.groups.philippines.diskoConfigurations a)


# comb/banana/hardwareProfiles.nix
{
  inputs,
  cell,
  ...
} @ a:
{}
// (cell.groups.philippines.hardwareProfiles a)


# comb/banana/nixosConfigurations.nix
{
  inputs,
  cell,
  ...
} @ a:
{}
// (cell.groups.philippines.nixosConfigurations a)


# comb/banana/nixosModules.nix
{
  inputs,
  cell,
  ...
} @ a:
{}
// (cell.groups.philippines.nixosModules a)


# comb/banana/nixosProfiles.nix
{
  inputs,
  cell,
  ...
} @ a:
{}
// (cell.groups.philippines.nixosProfiles a)
```
# Group
```nix
# comb/group/diskoConfigurations.nix
# or comb/group/hardwareProfiles.nix
# or comb/group/nixosModules.nix
# or comb/group/nixosProfiles.nix
# Shared libraries are in comb/lib
with inputs.cells.lib.diskoConfigurations; {
  banana-philippines = {};
}
```
# Host
```nix
# comb/host/nixosProfiles.nix
{
  banana-philippines-instance00 = {};
  banana-philippines-instance01 = {};
  banana-philippines-instance02 = {};
  banana-philippines-instance03 = {};
}
```
# Lib
```nix
# comb/lib/helpers.nix
{
  group.new = args:
    inputs.hive-group.group.new ({
        #instancePrefix = "machine";
        pkgs = inputs.nixos-24-05.legacyPackages;
        stateVersion = "24.05";
        system = "aarch64-linux";
      }
      // args);
}
```
# `flake.nix`
```nix
{
  inputs.colmena.url = "github:zhaofengli/colmena";
  inputs.disko.url = "github:nix-community/disko";
  inputs.hive-group.url = "github:whs-dot-hk/hive-group";
  inputs.hive.url = "github:divnix/hive";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.std.url = "github:divnix/std";

  inputs.hive.inputs.nixpkgs.follows = "nixpkgs";
  inputs.std.inputs.nixpkgs.follows = "nixpkgs";

  inputs.hive.inputs.colmena.follows = "colmena";
  
  inputs.nixos-24-05.url = "github:nixos/nixpkgs/release-24.05";
  ...
}
```
