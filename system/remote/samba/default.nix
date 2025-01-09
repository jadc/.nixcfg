{
    services.samba = {
        enable = true;
        openFirewall = true;
        settings = {
            global = {
                "workgroup" = "WORKGROUP";
                "server string" = "smbnix";
                "netbios name" = "smbnix";
                "security" = "user";
                #"hosts allow" = "192.168.0. 127.0.0.1 localhost";
                #"hosts deny" = "0.0.0.0/0";
                "guest account" = "nobody";
                "map to guest" = "bad user";
            };
            share = {
                "path" = "/data";
                "browseable" = "yes";
                "read only" = "no";
                "guest ok" = "yes";
                "create mask" = "0644";
                "directory mask" = "0755";
                "force user" = "jad";
                "force group" = "wheel";
            };
        };
    };

    # Advertises Samba shares to Windows hosts
    services.samba-wsdd = {
        enable = true;
        discovery = true;
        openFirewall = true;
        extraOptions = [ "--verbose" ];
    };

    # Ensures firewall is open
    networking.firewall.enable = true;
    networking.firewall.allowPing = true;
}
