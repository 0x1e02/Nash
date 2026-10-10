{ config, pkgs, ... }:
{
  environment.etc."paperless-admin-pass".text = "admin";
  services.paperless = {
    enable = true;
    address = "0.0.0.0";
    passwordFile = "/etc/paperless-admin-pass";
    settings = {
      PAPERLESS_OCR_LANGUAGE = "deu+eng";
      PAPERLESS_TASK_WORKERS = 6;
    };
  };
  networking.firewall = {
      allowedTCPPorts = [ 28981 ];
  };
}