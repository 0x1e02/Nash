{ config, pkgs, ... }:
{
  environment.etc."paperless-admin-pass".text = "admin";
  services.paperless = {
    enable = true;
    address = "0.0.0.0";
    passwordFile = "/etc/paperless-admin-pass";
  };
  networking.firewall = {
      allowedTCPPorts = [ 28981 ];
  };
}