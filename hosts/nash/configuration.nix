{ config, pkgs, ... }:
{
  networking.hostName = "nash";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader (systemd-boot on the NVMe ESP)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Berlin"; # adjust to your timezone

  boot.initrd.availableKernelModules = [
    "nvme" "ahci" "sd_mod"       # storage controllers
    "md_mod" "raid1"             # RAID1 / md assembly
    "bcache"                     # bcache backing + cache registration
    "dm_crypt" "dm_mod"          # LUKS / device-mapper
    "dm_thin_pool"               # LVM thin provisioning
    "usb_storage"
    "uas"      # if the device uses USB Attached SCSI
    "xhci_pci" # USB 3 controllers
    "ehci_pci" # USB 2 controllers if needed
  ];

  # boot.initrd.services.lvm.enable = true;

  networking.firewall.allowedTCPPorts = [ 80 443 22 ];
  networking.networkmanager.enable = true;

  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICFLSh8+F3ZA0H6F8IBClfrMfDJIyYvt7Ytj3CeanonX ell@dirac"
    ];
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  security.sudo.extraRules = [
    {
      users = [ "admin" ];
      commands = [ { command = "ALL"; options = [ "NOPASSWD" ]; } ];
    }
  ];

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
  ];

  system.stateVersion = "26.05"; # keep this pinned to the release you installed with
}
