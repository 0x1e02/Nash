{ config, pkgs, ... }:
{
  services.nsd = {
    enable = true;
    interfaces = [ "0.0.0.0" "::" ];

    services.nsd.zones."internal".data = ''
      $ORIGIN internal.
      $TTL 300

      @    IN SOA  ns1.internal. hostmaster.internal. (
                    2026101704 ; serial, bump on every change
                    7200       ; refresh
                    3600       ; retry
                    1209600    ; expire
                    300 )      ; negative TTL

      @    IN NS   ns1.internal.
      ns1  IN A    100.94.153.102   ; nash's tailscale IP

      *    IN CNAME nash.gila-pythagorean.ts.net.   ; MagicDNS name, trailing dot required
    '';

  networking.firewall.allowedUDPPorts = [ 53 ];
  networking.firewall.allowedTCPPorts = [ 53 ];
}