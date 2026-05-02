{ ... }:

{
    flake.modules.homeManager.rebuild = { pkgs, ... }: {
        home.packages = [
            (pkgs.writeShellApplication {
                name = "rebuild";
                text = if pkgs.stdenv.isDarwin then ''
                    sudo -u "$USER" darwin-rebuild switch --flake "$HOME/.nixcfg"
                '' else ''
                    if grep -q "NixOS" /etc/os-release; then
                        sudo nixos-rebuild switch --flake "$HOME/.nixcfg"
                    else
                        home-manager switch --flake "$HOME/.nixcfg#home-${pkgs.stdenv.hostPlatform.system}"
                    fi
                '';
            })
        ];
    };
}
