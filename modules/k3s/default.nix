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
            services.k3s = {
                enable = true;
                role = "server";
                extraFlags = toString [
                    "--kubelet-arg=eviction-hard=nodefs.available<5%,imagefs.available<5%"
                    "--kubelet-arg=root-dir=/var/lib/rancher/k3s/agent/kubelet"
                ];
            };

            networking.firewall.allowedTCPPorts = [ 6443 ];

            cfg.save.home.dirs = [ ".kube" ];
            cfg.save.root.dirs = [
                "/var/lib/rancher/k3s"
                "/etc/rancher"
            ];
        };
    };
}
