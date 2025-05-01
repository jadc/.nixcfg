# Rsync: a fast, versatile, remote (and local) file-copying tool

{ pkgs, ... }:

{
    config = {
        home.packages = with pkgs; [ rsync ];

        common.aliases.rsync="rsync -avhP --no-compress";
    };
}
