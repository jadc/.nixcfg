{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.nixos.${name} = { ... }: {
        services.gnome.gnome-keyring.enable = true;
        security.pam.services.greetd.enableGnomeKeyring = true;
    };

    flake.modules.homeManager.${name} = { ... }: {
        cfg.impermanence.home.dirs = [ ".local/share/keyrings" ];
    };
}
