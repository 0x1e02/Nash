{ config, pkgs, ... }:
{
  services.caddy = {
    enable = true;
    virtualHosts."nash".extraConfig = ''
      tls internal
      respond "Hello, world!"
    '';
  };
}