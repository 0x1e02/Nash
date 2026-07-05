# Setup Documentation for `nash` -- a Home NAS and Lab System

## Disk Encryption
The disk setup is described in `disko.nix`. Evaluate
```sh
sudo nix run github:nix-community/disko \
    --extra-experimental-features "nix-command flakes"  -- \
    --mode format ./disko.nix
```
to create the new partitioning scheme and the described filesystem.
If the devices are not clean `--mode destroy` needs to preceed.
Other modes are `mount` / `unmount`. Also the sequences
`format,mount` and `destroy,format,mount` are recognized.

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
