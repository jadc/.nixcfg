{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.nixos.${name} = { ... }: {
        services.openssh.enable = true;

        # Persist host keys for stable identity across boots
        cfg.save.root.files = [
            { file = "/etc/ssh/ssh_host_ed25519_key"; mode = "0600"; }
            "/etc/ssh/ssh_host_ed25519_key.pub"
            { file = "/etc/ssh/ssh_host_rsa_key"; mode = "0600"; }
            "/etc/ssh/ssh_host_rsa_key.pub"
        ];

        cfg.save.home.dirs = [ ".ssh" ];
    };
}
