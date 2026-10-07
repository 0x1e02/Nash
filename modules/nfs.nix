{ config, pkgs, ... }:
{
    services.nfs.server = {
        enable = true;
        exports = ''
        /srv/share                    *(rw,insecure,fsid=0,no_subtree_check)
        /srv/share/ruth               192.168.0.0/24(rw,sync,nohide,insecure,no_subtree_check,all_squash)
        /srv/share/ell                *(rw,sync,nohide,insecure,no_subtree_check,all_squash,crossmnt)
        '';
    };

    # services.stunnel = {
    #     enable = true;
    #     servers = {
    #         nfs = {
    #             accept = "0.0.0.0:2222";
    #             connect = "127.0.0.1:2049";
    #             cert = "/etc/stunnel/stunnel.crt";
    #             key  = "/etc/stunnel/stunnel.key";
    #             verifyPeer = true;
    #             CAfile = "/etc/stunnel/stunnel.crt";
    #         };
    #     };
    # };

    networking.firewall = {
        allowedTCPPorts = [ 2049 111 ];
    };

    systemd.tmpfiles.rules = [
        "d /srv/share 0755 root root -"
        "d /srv/share/ell 0755 root root -"
    ];

    fileSystems."/srv/share/ell/Papra-ingestion" = {
        device = "/data/ell/Papra/ingestion";
        fsType = "none";
        options = [ "bind" ];
    };

}