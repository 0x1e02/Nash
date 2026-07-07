{ ... }:
{
  disko.devices = {
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [
        "size=2G"
        "defaults"
        "mode=755"
      ];
    };

    disk.nvme = {
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
              extraArgs = [ "-f" ];

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

              content = { type = "lvm_pv"; vg="vg0"; };
            };
          };
        };
      };
    };

    lvm_vg.vg0 = {
      type = "lvm_vg";
      lvs = {
        thinpool = {
          size = "98%";
          lvm_type = "thin-pool"
        };
      };
    };
  };

  fileSystems."/persist".neededForBoot = true;
}
