{ config, pkgs, ... }:
{
  services.caddy = {
    enable = true;
    virtualHosts."localhost".extraConfig = ''
      tls internal
      respond "Hello, world!"
    '';
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}