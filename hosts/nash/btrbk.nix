{ ... }:
{
  services.btrbk = {
    instances."data" = {
      onCalendar = "hourly";
      settings = {
        snapshot_preserve_min = "2d";
        snapshot_preserve = "48h 14d 6m";

        volume."/data/ell" = {
          subvolume = ".";
          snapshot_dir = ".snapshots";
        };

        volume."/data/ruth" = {
          subvolume = ".";
          snapshot_dir = ".snapshots";
        };
      };
    };
  };
}
