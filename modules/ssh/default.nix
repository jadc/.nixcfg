{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            enable = lib.mkEnableOption name;
        };
    };

    flake.modules.nixos.${name} = { config, lib, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            services.openssh.enable = true;
            services.openssh.settings.X11Forwarding = true;

            # Persist host keys for stable identity across boots
            cfg.save.root.files = [
                { file = "/etc/ssh/ssh_host_ed25519_key"; mode = "0600"; }
                "/etc/ssh/ssh_host_ed25519_key.pub"
                { file = "/etc/ssh/ssh_host_rsa_key"; mode = "0600"; }
                "/etc/ssh/ssh_host_rsa_key.pub"
            ];
        };
    };

    flake.modules.homeManager.${name} = { config, lib, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            cfg.save.home.dirs = [ ".ssh" ];
        };
    };
}
