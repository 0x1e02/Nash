{ config, pkgs, ... }:
{
  services.paperless = {
    enable = false;
    configureTika = true;
    address = "0.0.0.0";
    # dataDir = "/data/ell/paperless";
    settings = {
      PAPERLESS_OCR_LANGUAGE = "deu+eng";
      PAPERLESS_TASK_WORKERS = 6;
      PAPERLESS_IGNORE_DATES = "2002-08-21";
    };
  };

  networking.firewall = {
      allowedTCPPorts = [ 28981 ];
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/paperless 0755 paperless paperless -"
  ];

  # systemd.tmpfiles.rules = [
  #   "d /data/ell/paperless 0755 paperless paperless -"
  # ];

  # fileSystems."/var/lib/paperless" = {
  #     device = "/data/ell/paperless";
  #     fsType = "none";
  #     options = [ "bind" ];
  # };
}