{ config, pkgs, ... }:

let
    rebuild = pkgs.writeShellApplication {
        name = "rebuild";
        text =
            if (pkgs.stdenv.isDarwin) then
                ''sudo -u "$USER" darwin-rebuild switch --accept-flake-config --flake "$HOME/.nixcfg"#${config.common.profile}''
            else
                ''
                if grep -q "NixOS" /etc/os-release; then
                    sudo nixos-rebuild switch --accept-flake-config --flake "$HOME/.nixcfg"#${config.common.profile};
                else
                    home-manager switch --accept-flake-config --flake "$HOME/.nixcfg"#${config.common.profile}-${pkgs.system};
                fi
                ''
            ;
    };
in
{
    # Add script to pkgs
    home.packages = [ rebuild ];
}
