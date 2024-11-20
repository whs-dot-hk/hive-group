{
  POP,
  lib,
}: {
  new = {
    groupName ? "",
    groups ? ["a" "b" "c"],
    instancePrefix ? "instance",
    ips ? [""],
    pkgs,
    prefix,
    start ? 0,
    stateVersion,
    system,
  }: let
    end = start + builtins.length ips - 1;
    groupName' =
      if groupName == ""
      then ""
      else "${groupName}-";
    fullGroupName = assert (builtins.match ".+-" prefix != null);
      if groupName == ""
      then builtins.substring 0 (builtins.stringLength prefix - 1) prefix
      else prefix + groupName;
    instanceNumber = n: let
      n' = assert (n < 100); builtins.toString n;
    in
      if builtins.stringLength n' < 2
      then "0${n'}"
      else n';
    instanceName = n: instancePrefix + instanceNumber x;
    generateInstancesWithValues = values: f:
      builtins.listToAttrs (builtins.concatLists (lib.lists.imap0 (i: v: let
          instanceName' = instanceName n;
        in [
          (
            lib.attrsets.nameValuePair
            groupName'
            + instanceName'
            (f instanceName' i v)
          )
        ])
        values));
    generateInstancesWithRange = start: end: f:
      builtins.listToAttrs (builtins.concatMap (n: let
          instanceName' = instanceName n;
        in [
          (
            lib.attrsets.nameValuePair
            groupName'
            + instanceName'
            (f instanceName')
          )
        ])
        (lib.lists.range start end));
    generateInstancesFor = blockType: start: end: {inputs, ...}:
      generateInstancesWithRange start end (_: {
        imports = [
          inputs.cells.group.${blockType}.${fullGroupName}
        ];
      });
    generateInstancesForColmenaConfigurations = ips: {cell, ...}:
      generateInstancesWithValues ips
      (instanceName: n: ip: let
        group = builtins.elemAt groups (lib.trivial.mod n (builtins.length groups));
      in {
        deployment = {
          targetHost = ip;
          tags = ["${fullGroupName}-group-${group}"] ++ lib.lists.optional ("${fullGroupName}-" != prefix) "${prefix}group-${group}";
        };
        imports = [
          cell.nixosConfigurations."${groupName'}${instanceName}"
        ];
      });
    generateInstancesForNixosConfigurations = start: end: bee: system: {
      inputs,
      cell,
      ...
    }:
      generateInstancesWithRange start end (instanceName: {
        inherit bee;
        inherit system;
        imports = let
          disko = assert (inputs ? disko); inputs.disko.nixosModules.disko;
          host = inputs.cells.host.nixosProfiles."${fullGroupName}-${instanceName}" or {};
        in [
          cell.diskoConfigurations."${groupName'}${nodeName}"
          cell.hardwareProfiles."${groupName'}${nodeName}"
          cell.nixosModules."${groupName'}${nodeName}"
          cell.nixosProfiles."${groupName'}${nodeName}"
          disko
          host
        ];
      });
  in
    POP.lib.kPop {
      inherit end;

      colmenaConfigurations = generateInstancesForColmenaConfigurations ips;
      diskoConfigurations = generateInstancesFor "diskoConfigurations" start end;
      hardwareProfiles = generateInstancesFor "hardwareProfiles" start end;
      nixosModules = generateInstancesFor "nixosModules" start end;
      nixosProfiles = generateInstancesFor "nixosProfiles" start end;
      nixosConfigurations = generateInstancesForNixosConfigurations start end {
        inherit pkgs;
        inherit system;
      } {inherit stateVersion;};
    };
}
