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
# Shared libraries are in comb/lib
with inputs.cells.lib.diskoConfigurations; {
  banana-philippines = {};
}


# comb/group/hardwareProfiles.nix
with inputs.cells.lib.hardwareProfiles; {
  banana-philippines = {};
}


# comb/group/nixosModules.nix
with inputs.cells.lib.nixosModules; {
  banana-philippines = {};
}


# comb/group/nixosProfiles.nix
with inputs.cells.lib.nixosProfiles; {
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
# Colmena
```sh
colmena apply --on @banana-group-a
colmena apply --on @banana-philippines-group-a
colmena apply --on banana-philippines-instance00
```
# FAQ: how to add another group?
```nix
# comb/banana/groups.nix
with inputs.cells.lib.helpers; {
  philippines = ...
  other = group.new {
    groupName = "other";
    prefix = "banana-";
    ips = [
      "10.0.20.1"
      "10.0.20.2"
      "10.0.20.3"
      "10.0.20.4"
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
// (cell.groups.other.colmenaConfigurations a)


# comb/banana/diskoConfigurations.nix
{
  inputs,
  cell,
  ...
} @ a:
{}
// (cell.groups.philippines.diskoConfigurations a)
// (cell.groups.other.diskoConfigurations a)


# comb/banana/hardwareProfiles.nix
{
  inputs,
  cell,
  ...
} @ a:
{}
// (cell.groups.philippines.hardwareProfiles a)
// (cell.groups.other.hardwareProfiles a)


# comb/banana/nixosConfigurations.nix
{
  inputs,
  cell,
  ...
} @ a:
{}
// (cell.groups.philippines.nixosConfigurations a)
// (cell.groups.other.nixosConfigurations a)


# comb/banana/nixosModules.nix
{
  inputs,
  cell,
  ...
} @ a:
{}
// (cell.groups.philippines.nixosModules a)
// (cell.groups.other.nixosModules a)


# comb/banana/nixosProfiles.nix
{
  inputs,
  cell,
  ...
} @ a:
{}
// (cell.groups.philippines.nixosProfiles a)
// (cell.groups.other.nixosProfiles a)


# comb/group/diskoConfigurations.nix
with inputs.cells.lib.diskoConfigurations; {
  banana-philippines = ...
  banana-other = {};
}


# comb/group/hardwareProfiles.nix
with inputs.cells.lib.hardwareProfiles; {
  banana-philippines = ...
  banana-other = {};
}


# comb/group/nixosModules.nix
with inputs.cells.lib.nixosModules; {
  banana-philippines = ...
  banana-other = {};
}


# comb/group/nixosProfiles.nix
with inputs.cells.lib.nixosProfiles; {
  banana-philippines = ...
  banana-other = {};
}


# comb/host/nixosProfiles.nix
{
  banana-philippines-instance00 = ...
  ...
  banana-philippines-instance03 = ...
  banana-other-instance00 = {}; # Optional
  banana-other-instance01 = {};
  banana-other-instance02 = {};
  banana-other-instance03 = {};
}
```
