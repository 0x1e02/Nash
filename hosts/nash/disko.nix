{ config, lib, pkgs, ... }:
let
  storageUserData = import ./storage-users.nix;  
  storageUsers    = lib.attrNames storageUserData;  

  userSubvolumes = lib.listToAttrs (
    lib.concatMap (name: [
      {
        name = "/${name}";
        value = {
          mountpoint = "/data/${name}";
          mountOptions = [
            "compress=zstd"
            "noatime"
          ];
        };
      }
      {
        name = "/${name}/.snapshots";
        value = { };
      }
    ]) storageUsers
  );

  nodevBackupMounts = lib.listToAttrs (
    map (name: {
      name = "/home/${name}/Backups";
      value = {
        fsType = "none";
        device = "/data/${name}/Backups";
        mountOptions = [ "bind" ];
      };
    }) storageUsers
  );

in
{
  disko.devices.nodev = {
    "/" = {
      fsType = "tmpfs";
      mountOptions = [
        "size=2G"
        "defaults"
        "mode=755"
      ];
    };
  } // nodevBackupMounts;

  disko.devices.disk = {
    nvme = {
      type = "disk";
      device = "/dev/nvme0n1";
      content = {
        type = "gpt";
        partitions = {

          boot = {
            name = "boot";
            size = "4G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };

          root = {
            name = "root";
            size = "32G";
            content = {
              type = "btrfs";
              # extraArgs = [ "-f" ];

              subvolumes = {
                "/nix" = {
                  mountpoint = "/nix";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };

                "/persist" = {
                  mountpoint = "/persist";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };

                "/snapshots" = { };
              };
            };
          };

          data = {
            name = "data";
            size = "100%";
            content = {
              type = "luks";
              name = "cryptdata";
              
              keyFile= "/dev/disk/by-partlabel/KEY";
              settings = {
                allowDiscards = true;
                keyFile = "/dev/disk/by-partlabel/KEY";
              };

              content = {
                type = "btrfs";
                subvolumes = userSubvolumes;
              };
            };
          };
        };
      };
    };
  };
  fileSystems."/persist".neededForBoot = true;
}
