{ config, pkgs, ... }:

let
    rebuild = pkgs.writeShellApplication {
        name = "rebuild";
        text =
            if (pkgs.stdenv.isDarwin) then
                ''sudo -u "$USER" darwin-rebuild switch --flake "$HOME/.nixcfg"#${config.common.hostname}''
            else
                ''
                if grep -q "NixOS" /etc/os-release; then
                    sudo nixos-rebuild switch --flake "$HOME/.nixcfg"#${config.common.hostname};
                else
                    home-manager switch --flake "$HOME/.nixcfg"#${config.common.hostname};
                fi
                ''
            ;
    };
in
{
    # Add script to pkgs
    home.packages = [ rebuild ];
}
