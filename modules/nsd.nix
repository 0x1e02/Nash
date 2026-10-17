{ config, pkgs, ... }:
{
  services.nsd = {
    enable = true;
    interfaces = [ "0.0.0.0" "::" ];

    zones."example.net".data = ''
      $ORIGIN example.net.
      $TTL 3600

      @   IN SOA  ns1.example.org. hostmaster.example.org. (
                    2026101701 ; serial, bump on every change
                    7200       ; refresh
                    3600       ; retry
                    1209600    ; expire
                    3600 )     ; negative TTL

      @   IN NS   ns1.example.org.

      *   IN CNAME example.net.
    '';
  };

  networking.firewall.allowedUDPPorts = [ 53 ];
  networking.firewall.allowedTCPPorts = [ 53 ];
}