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
                '' + (if pkgs.stdenv.hostPlatform.isDarwin then ''
                    echo "darwin-rebuild $action"
                    sudo -u "$USER" darwin-rebuild "$action" --flake "$repo#$hostname" && sudo nix-collect-garbage --quiet
                '' else ''
                    if grep -q "NixOS" /etc/os-release; then
                        echo "nixos-rebuild $action"
                        sudo nixos-rebuild "$action" --flake "$repo#$hostname" && sudo nix-collect-garbage --quiet
                    else
                        echo "home-manager switch"
                        home-manager switch --flake "$repo#work-${pkgs.stdenv.hostPlatform.system}" && nix-collect-garbage -d --quiet
                    fi
                '');
            })
        ];
    };
}
