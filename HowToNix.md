```sh
cat /etc/nix/nix.conf
#
# https://nixos.org/manual/nix/stable/#sec-conf-file
#

# Unix group containing the Nix build user accounts
build-users-group = nixbld
experimental-features = nix-command flakes

```

```sh
sudo nix flake update
```


