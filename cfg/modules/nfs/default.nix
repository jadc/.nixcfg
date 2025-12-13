{ config, lib, ... }:

let
    name = "nfs";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        services.nfs.server = {
            enable = true;
            exports = "/data *(rw,insecure,fsid=0,no_subtree_check,anonuid=1000,anongid=1000,all_squash)";

            # fixed rpc.statd port; for firewall
            lockdPort = 4001;
            mountdPort = 4002;
            statdPort = 4000;
            extraNfsdConfig = '''';
        };

        # Open ports
        networking.firewall = let
            NFSv3 = [ 111 2049 4000 4001 4002 20048 ];
        in {
            enable = true;
            # for NFSv3; view with `rpcinfo -p`
            allowedTCPPorts = NFSv3;
            allowedUDPPorts = NFSv3;
        };
    };
}
