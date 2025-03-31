{ pkgs, ... }:

{
    environment.systemPackages = [ pkgs.filebrowser ];

    # Create user and group for file browser to operate as
    users.groups.filebrowser = {};
    users.users.filebrowser = {
        isSystemUser = true;
        group = "filebrowser";
    };

    # Create temporary directories for file browser temp files
    systemd.tmpfiles.rules = [
        "d /var/lib/filebrowser 0770 filebrowser filebrowser"
        "d /var/cache/filebrowser/storage 0770 filebrowser filebrowser"
    ];

    # Create systemd service to run filebrowser on boot
    systemd.services.filebrowser = {
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
            Type = "simple";
            User = "filebrowser";
            Restart = "on-failure";
            ExecStart = ''${pkgs.filebrowser}/bin/filebrowser \
                --port 8888 \
                --database /var/lib/filebrowser/filebrowser.db \
                --cache-dir /var/cache/filebrowser \
                --root /data \
                --disable-exec
            '';
        };
    };

    # Open filewall port for web ui
    networking.firewall.allowedTCPPorts = [ 8888 ];
}
