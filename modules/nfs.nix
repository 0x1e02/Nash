{ config, pkgs, ... }:
{
    services.nfs.server = {
        enable = true;
        exports = ''
        /srv/nfs                    192.168.0.0/24(rw,fsid=0,no_subtree_check)
        /srv/nfs/ruth               192.168.0.0/24(rw,sync,nohide,insecure,no_subtree_check,all_squash)
        /srv/nfs/ell                192.168.0.0/24(rw,sync,nohide,insecure,no_subtree_check,all_squash)
        /srv/nfs/ell                127.0.0.0/8(rw,sync,nohide,insecure,no_subtree_check,all_squash)
        '';
    };

    services.stunnel = {
        enable = true;
        servers = {
            nfs = {
                accept = "0.0.0.0:2222";
                connect = "127.0.0.1:2049";
                cert = "/etc/stunnel/stunnel.crt";
                key  = "/etc/stunnel/stunnel.key";
                verifyPeer = true;
                CAfile = "/etc/stunnel/stunnel.crt";
            };
        };
    };

    networking.firewall = {
        allowedTCPPorts = [ 2049 2222 ];
    };
}