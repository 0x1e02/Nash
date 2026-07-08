{ config, pkgs, ... }:
{
    services.nfs.server = {
        enable = true;
        exports = ''
        /srv/nfs                    192.168.0.0/24(rw,fsid=0,no_subtree_check)
        /srv/nfs/ruth               192.168.0.0/24(rw,sync,nohide,insecure,no_subtree_check,all_squash,anonuid=65534,anongid=65534)
        /srv/nfs/ell                192.168.0.0/24(rw,sync,nohide,insecure,no_subtree_check,all_squash,anonuid=65534,anongid=65534)
        '';
    };

    networking.firewall = {
        allowedTCPPorts = [ 2049 ];
    };
}