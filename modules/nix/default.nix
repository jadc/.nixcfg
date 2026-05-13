{ ... }:

{
    flake.modules.nixos.nix = { config, pkgs, ... }: {
        nixpkgs.config.allowUnfree = true;

        # Enable compatibility shim for dynamically linked executables
        programs.nix-ld.enable = true;

        nix.settings = {
            auto-optimise-store = pkgs.stdenv.isLinux;

            # Enable flakes
            experimental-features = [ "nix-command" "flakes" ];

            # Use pre-compiled binaries from nix-community cache if available
            substituters = [ "https://nix-community.cachix.org" ];
            trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
            trusted-users = [ "@wheel" ];
        };

        nix.gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
        };

        system.stateVersion = config.cfg.const.stateVersion;
    };

    flake.modules.homeManager.nix = {
        # Allow unfree packages in nix shells
        xdg.configFile."nixpkgs/config.nix".text = ''{ allowUnfree = true; }'';
    };
}
