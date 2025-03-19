{ pkgs, ... }:

{
    home.packages = with pkgs; [ sshfs-fuse ];
}
