{ ... }:

{
    flake.modules.homeManager.rebuild = { config, pkgs, ... }: {
        home.packages = [
            (pkgs.writeShellApplication {
                name = "rebuild";
                text = ''
                    repo="${config.home.homeDirectory}/.nixcfg"
                    hostname="$(hostname)"

                    if [ "''${1:-}" = "now" ]; then
                        action="switch"
                    else
                        action="boot"
                    fi
                '' + (if pkgs.stdenv.isDarwin then ''
                    echo "darwin-rebuild $action"
                    sudo -u "$USER" darwin-rebuild "$action" --flake "$repo#$hostname"
                '' else ''
                    if grep -q "NixOS" /etc/os-release; then
                        echo "nixos-rebuild $action"
                        sudo nixos-rebuild "$action" --flake "$repo#$hostname"
                    else
                        echo "home-manager switch"
                        home-manager switch --flake "$repo#home-${pkgs.stdenv.hostPlatform.system}"
                    fi
                '');
            })
        ];
    };
}
