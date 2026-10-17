{ config, pkgs, ... }:
{
  services.caddy = {
    enable = true;

    virtualHosts."paperless.internal".extraConfig = ''
      tls internal
      respond "Hello, world!"
    '';

    # virtualHosts."paperless.gila-pythagorean.ts.net".extraConfig = ''
    #   tls internal
    #   respond "Hello, world..."
    # '';
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}