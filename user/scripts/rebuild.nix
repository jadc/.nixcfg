{ config, pkgs, ... }:

let
    rebuild = pkgs.writeShellApplication {
        name = "rebuild";
        text =
            if (pkgs.stdenv.isDarwin) then
                ''sudo -u "$USER" darwin-rebuild switch --flake "$HOME/.nixcfg"#${config.common.profile}''
            else
                ''
                if grep -q "NixOS" /etc/os-release; then
                    sudo nixos-rebuild switch --flake "$HOME/.nixcfg"#${config.common.profile};
                else
                    home-manager switch --flake "$HOME/.nixcfg"#${config.common.profile};
                fi
                ''
            ;
    };
in
{
    # Add script to pkgs
    home.packages = [ rebuild ];
}
