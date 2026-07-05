# Setup Documentation for `nash` -- a Home NAS and Lab System
Get disko via `nix shell github:nix-community/disko`
and verify it worked with
`disko --help`.


The disk setup is described in `disko.nix`. Evaluate
```sh
disko --mode format --flake github:0x1e02/Nash#nash
```
to create the new partitioning scheme and the described filesystem.
If the devices are not clean `--mode destroy` needs to preceed.
Other modes are `mount` / `unmount`. Also the sequences
`format,mount` and `destroy,format,mount` are recognized.

## Disk Encryption
For encrypting
`/dev/nvme0n1p3` a separate partition,
serving as a keyfile, must be created.
A proper key partition is exactly `4096` bytes large
and has `KEY` as the partition label.
Its contents can be generated with
```sh
dd if=/dev/urandom bs=512 count=8
```
If `gdisk` should be used for partitioning,
then `+4k` for the partitions end is exact
and the `c` command lets you set the `partition label`.

## Installation
After everything has been mounted and made available
you must unmount /mnt/data if using btrfs. Then
generate the `hardware-configuration.nix` via.
```sh
nixos-generate-config --root /mnt --no-filesystems --show-hardware-config
```

