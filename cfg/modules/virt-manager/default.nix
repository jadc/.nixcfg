{ ... }:

{
    home-manager.sharedModules = [ ./home.nix ];

    programs.dconf.enable = true;
}
