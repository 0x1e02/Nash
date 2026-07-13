{ config, pkgs, lib, ... }:
let
  storageUserData = import ./storage-users.nix;  
in
{
  networking.hostName = "nash";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader (systemd-boot on the NVMe ESP)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Berlin"; # adjust to your timezone

  networking.firewall.allowedTCPPorts = [ 80 443 22 ];
  networking.networkmanager.enable = true;
  
  services.tailscale.enable = true;

  users.groups."storage" = {};
  users.users = {
    admin = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICFLSh8+F3ZA0H6F8IBClfrMfDJIyYvt7Ytj3CeanonX ell@dirac"
      ];
    };
  } // lib.mapAttrs (name: data: {
    isNormalUser = true;
    openssh.authorizedKeys.keys = data.authorizedKeys;
    extraGroups = [ "storage" ];
  }) storageUserData;

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    neovim
    curl
    wget
    vim
    git
    htop
    lvm2
    tree
    mdadm
    cryptsetup
    efibootmgr
    disko
  ];

  environment.persistence."/persist" = {
    directories = [
      "/etc/nixos"
      "/var/log"
      "/var/lib"
    ];

    files = [
      # needed by systemd
      "/etc/machine-id"

      # ssh host key pairs
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"

      # stunnel keys for nfs
      "/etc/stunnel/stunnel.key"
      "/etc/stunnel/stunnel.crt"
    ];
  };

  system.stateVersion = "26.05"; # keep this pinned to the release you installed with
}
