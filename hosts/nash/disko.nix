{ ... }:
{
  disko.devices = {
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
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
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
                type = "filesystem";
                format = "btrfs";
                mountpoint = "/data";
              };
            };
          };
        };
      };
    };
  };
}
