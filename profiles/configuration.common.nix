# The following home.nix is shared amongst all profiles
# You shouldn't need to modify this file.

{ common, pkgs, ... }:

{
    # Hostname
    networking.hostName = common.hostname;

    # Rebuild won't work without git
    environment.systemPackages = with pkgs; [ git ];

    # Enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Do not need to update
    system.stateVersion = "24.05";
}
