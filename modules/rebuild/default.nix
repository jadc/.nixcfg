{ ... }:

{
    flake.modules.homeManager.rebuild = { config, pkgs, ... }: let flake = config.cfg.const.flakePath; in {
        home.packages = [
            (pkgs.writeShellApplication {
                name = "rebuild";
                text = ''
                    flake="${flake}"

                    if [ "''${1:-}" = "now" ]; then
                        action="switch"
                    else
                        action="boot"
                    fi
                '' + (if pkgs.stdenv.isDarwin then ''
                    echo "darwin-rebuild $action"
                    sudo -u "$USER" darwin-rebuild "$action" --flake "$flake"
                '' else ''
                    if grep -q "NixOS" /etc/os-release; then
                        echo "nixos-rebuild $action"
                        sudo nixos-rebuild "$action" --flake "$flake"
                    else
                        echo "home-manager switch"
                        home-manager switch --flake "$flake#home-${pkgs.stdenv.hostPlatform.system}"
                    fi
                '');
            })
        ];
    };
}
