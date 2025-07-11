{ pkgs, ... }:

{
    home.packages = [
        (pkgs.writeShellApplication {
            name = "enter";
            text = ''nix-shell "$HOME/.nixcfg/user/envs/$1"'';
        })
    ];
}
