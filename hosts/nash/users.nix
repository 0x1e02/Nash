{ config, pkgs, ... }:
{
  users.users.ell = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIATg9YlVf77jeJoxbBuQhoFv6/GugmVqM/HlVE5RxyHj ell@lovelace"
    ];
  };
  users.users.ruth = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICsEuGocrVY3f6dIGj2yuKJwe020oHjC8L7p0w1b3wuH ruth@ThinkPadYoga"
    ];
  };
  users.users.nicola = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGxPiP8cxh5A/w/oQRX7+NseEk93l268IvP2iI0cLVPj nicola@donegal"
    ];
  };
}