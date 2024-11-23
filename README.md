# Example: banana
```nix
# comb/banana/groups.nix
with inputs.cells.lib.helpers; {
  delmonte = group.new {
    groupName = "delmonte";
    prefix = "banana-";
    ips = [
      "10.0.10.1"
      "10.0.10.2"
      "10.0.10.3"
      "10.0.10.4" # Max 100 ips
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
// (cell.groups.delmonte.colmenaConfigurations a)


# comb/banana/diskoConfigurations.nix
{
  inputs,
  cell,
  ...
} @ a:
{}
// (cell.groups.delmonte.diskoConfigurations a)


# comb/banana/hardwareProfiles.nix
{
  inputs,
  cell,
  ...
} @ a:
{}
// (cell.groups.delmonte.hardwareProfiles a)


# comb/banana/nixosConfigurations.nix
{
  inputs,
  cell,
  ...
} @ a:
{}
// (cell.groups.delmonte.nixosConfigurations a)


# comb/banana/nixosModules.nix
{
  inputs,
  cell,
  ...
} @ a:
{}
// (cell.groups.delmonte.nixosModules a)


# comb/banana/nixosProfiles.nix
{
  inputs,
  cell,
  ...
} @ a:
{}
// (cell.groups.delmonte.nixosProfiles a)
```
# Group
```nix
# comb/group/diskoConfigurations.nix
# Shared libraries are in comb/lib
with inputs.cells.lib.diskoConfigurations; {
  banana-delmonte = {};
}


# comb/group/hardwareProfiles.nix
with inputs.cells.lib.hardwareProfiles; {
  banana-delmonte = {};
}


# comb/group/nixosModules.nix
with inputs.cells.lib.nixosModules; {
  banana-delmonte = {};
}


# comb/group/nixosProfiles.nix
with inputs.cells.lib.nixosProfiles; {
  banana-delmonte = {};
}
```
# Host
```nix
# comb/host/nixosProfiles.nix
{
  banana-delmonte-instance00 = {}; # Two digits for sorting
  banana-delmonte-instance01 = {};
  banana-delmonte-instance02 = {};
  banana-delmonte-instance03 = {}; # From 00 to 99, do not go over 99
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
colmena apply --on @banana-delmonte-group-a
colmena apply --on banana-delmonte-instance00
```
# FAQ: how to add another brand (group)?
```nix
# comb/banana/groups.nix
with inputs.cells.lib.helpers; {
  delmonte = ...
  dole = group.new {
    groupName = "dole";
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
// (cell.groups.delmonte.colmenaConfigurations a)
// (cell.groups.dole.colmenaConfigurations a)


# comb/banana/diskoConfigurations.nix
{
  inputs,
  cell,
  ...
} @ a:
{}
// (cell.groups.delmonte.diskoConfigurations a)
// (cell.groups.dole.diskoConfigurations a)


# comb/banana/hardwareProfiles.nix
{
  inputs,
  cell,
  ...
} @ a:
{}
// (cell.groups.delmonte.hardwareProfiles a)
// (cell.groups.dole.hardwareProfiles a)


# comb/banana/nixosConfigurations.nix
{
  inputs,
  cell,
  ...
} @ a:
{}
// (cell.groups.delmonte.nixosConfigurations a)
// (cell.groups.dole.nixosConfigurations a)


# comb/banana/nixosModules.nix
{
  inputs,
  cell,
  ...
} @ a:
{}
// (cell.groups.delmonte.nixosModules a)
// (cell.groups.dole.nixosModules a)


# comb/banana/nixosProfiles.nix
{
  inputs,
  cell,
  ...
} @ a:
{}
// (cell.groups.delmonte.nixosProfiles a)
// (cell.groups.dole.nixosProfiles a)


# comb/group/diskoConfigurations.nix
with inputs.cells.lib.diskoConfigurations; {
  banana-delmonte = ...
  banana-dole = {};
}


# comb/group/hardwareProfiles.nix
with inputs.cells.lib.hardwareProfiles; {
  banana-delmonte = ...
  banana-dole = {};
}


# comb/group/nixosModules.nix
with inputs.cells.lib.nixosModules; {
  banana-delmonte = ...
  banana-dole = {};
}


# comb/group/nixosProfiles.nix
with inputs.cells.lib.nixosProfiles; {
  banana-delmonte = ...
  banana-dole = {};
}


# comb/host/nixosProfiles.nix
{
  banana-delmonte-instance00 = ...
  ...
  banana-delmonte-instance03 = ...
  banana-dole-instance00 = {}; # Optional
  banana-dole-instance01 = {};
  banana-dole-instance02 = {};
  banana-dole-instance03 = {};
}
```
# FAQ: how to add kiwi?
```nix
# comb/kiwi/groups.nix
with inputs.cells.lib.helpers; {
  zespri = group.new {
    groupName = "zespri";
    prefix = "kiwi-";
    ips = [
      "10.1.10.1"
      "10.1.10.2"
      "10.1.10.3"
      "10.1.10.4"
    ];
  };
}


# comb/kiwi/colmenaConfigurations.nix
{
  inputs,
  cell,
  ...
} @ a:
{}
// (cell.groups.zespri.colmenaConfigurations a)


# comb/kiwi/diskoConfigurations.nix
{
  inputs,
  cell,
  ...
} @ a:
{}
// (cell.groups.zespri.diskoConfigurations a)


# comb/kiwi/hardwareProfiles.nix
{
  inputs,
  cell,
  ...
} @ a:
{}
// (cell.groups.zespri.hardwareProfiles a)


# comb/kiwi/nixosConfigurations.nix
{
  inputs,
  cell,
  ...
} @ a:
{}
// (cell.groups.zespri.nixosConfigurations a)


# comb/kiwi/nixosModules.nix
{
  inputs,
  cell,
  ...
} @ a:
{}
// (cell.groups.zespri.nixosModules a)


# comb/kiwi/nixosProfiles.nix
{
  inputs,
  cell,
  ...
} @ a:
{}
// (cell.groups.zespri.nixosProfiles a)


# comb/group/diskoConfigurations.nix
with inputs.cells.lib.diskoConfigurations; {
  banana-delmonte = ...
  banana-dole = ...
  kiwi-zespri = {};
}


# comb/group/hardwareProfiles.nix
with inputs.cells.lib.hardwareProfiles; {
  banana-delmonte = ...
  banana-dole = ...
  kiwi-zespri = {};
}


# comb/group/nixosModules.nix
with inputs.cells.lib.nixosModules; {
  banana-delmonte = ...
  banana-dole = ...
  kiwi-zespri = {};
}


# comb/group/nixosProfiles.nix
with inputs.cells.lib.nixosProfiles; {
  banana-delmonte = ...
  banana-dole = ...
  kiwi-zespri = {};
}


# comb/host/nixosProfiles.nix
{
  banana-delmonte-instance00 = ...
  ...
  banana-dole-instance03 = ...
  kiwi-zespri-instance00 = {};
  kiwi-zespri-instance01 = {};
  kiwi-zespri-instance02 = {};
  kiwi-zespri-instance03 = {};
}
```
# FAQ: what will my lib look like?
```nix
# comb/lib/hardwareProfiles.nix
{
  aws = ...
  gcp = ...
}


# comb/lib/diskoConfigurations.nix
{
  without-second-disk = {
    disko.devices.disk = {
      ...
    };
  };
  with-second-disk = lib.attrsets.recursiveUpdate without-second-disk {
    disko.devices.disk = {
      ...
    };
  };
  gcp-without-second-disk = ...
  gcp-with-second-disk = ...
}


# comb/lib/nixosProfiles.nix
{
  aws-common = ...
  gcp-common = ...
  common = ... # Should available on every machine like vim
  users = ...
}
```
# FAQ: why do I need `comb/lib`, `comb/group` and `comb/host`?
When there are many machines, it is natural that some will have similiar purpose.
So there is group, at the same time each machine may have small difference. So there is host.
Lib is where I put everything, so I can pick what I need in group and host.
