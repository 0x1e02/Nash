{ config, pkgs, ... }:
{
  services.paperless = {
    enable = true;
    configureTika = true;
    address = "0.0.0.0";
    dataDir = "/data/ell/paperless";
    settings = {
      PAPERLESS_OCR_LANGUAGE = "deu+eng";
      PAPERLESS_TASK_WORKERS = 6;
      PAPERLESS_IGNORE_DATES = "2002-08-21";
    };
  };

  networking.firewall = {
      allowedTCPPorts = [ 28981 ];
  };
}