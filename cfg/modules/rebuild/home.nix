{ config, pkgs, ... }:

{
    home.packages = [
        (pkgs.writeShellApplication {
            name = "rebuild";
            text =
                if (pkgs.stdenv.isDarwin) then
                    ''sudo -u "$USER" darwin-rebuild switch --flake "$HOME/.nixcfg"#${config.cfg.const.profile}''
                else
                    ''
                    if grep -q "NixOS" /etc/os-release; then
                        sudo nixos-rebuild switch --flake "$HOME/.nixcfg"#${config.cfg.const.profile};
                    else
                        home-manager switch --flake "$HOME/.nixcfg"#${config.cfg.const.profile}-${pkgs.stdenv.hostPlatform.system};
                    fi
                    ''
                ;
        })
    ];
}
