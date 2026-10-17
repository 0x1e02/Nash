{ config, pkgs, ... }:
{
  services.caddy = {
    enable = true;

      virtualHosts."*.internal".extraConfig = ''
        tls internal
        respond "Not found" 404
      '';

    virtualHosts."paperless.internal".extraConfig = ''
      tls internal
      reverse_proxy http://localhost:28981
    '';

    # virtualHosts."paperless.gila-pythagorean.ts.net".extraConfig = ''
    #   tls internal
    #   respond "Hello, world..."
    # '';
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}