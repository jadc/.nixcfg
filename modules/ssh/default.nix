{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            enable = lib.mkEnableOption "SSH server";

            port = lib.mkOption {
                type = lib.types.port;
                default = 22;
                description = "Port on which the SSH server accepts connections.";
            };
        };
    };

    flake.modules.nixos.${name} = { config, lib, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            services.openssh = {
                enable = true;
                ports = [ self.port ];
                openFirewall = true;
                settings = {
                    PasswordAuthentication = false;
                    KbdInteractiveAuthentication = false;
                    PubkeyAuthentication = true;
                };
            };

            # Persist host keys for stable identity across boots
            cfg.save.root.files = [
                { file = "/etc/ssh/ssh_host_ed25519_key"; mode = "0600"; }
                "/etc/ssh/ssh_host_ed25519_key.pub"
                { file = "/etc/ssh/ssh_host_rsa_key"; mode = "0600"; }
                "/etc/ssh/ssh_host_rsa_key.pub"
            ];

            cfg.save.home.dirs = [ ".ssh" ];
        };
    };
}
