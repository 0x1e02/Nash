{ ... }:
{
  services.btrbk = {
    enable = true;
    instances."home" = {
      onCalendar = "hourly";
      settings = {
        snapshot_preserve_min = "2d";
        snapshot_preserve = "48h 14d 6m";

        volume."/home/ell" = {
          subvolume = ".";
          snapshot_dir = "/snapshots-data/ell";
        };

        volume."/home/ruth" = {
          subvolume = ".";
          snapshot_dir = "/snapshots-data/ruth";
        };
      };
    };
  };
}
