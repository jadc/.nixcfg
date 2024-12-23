{
    imports =
        [
            # Standard configuration
            ./../home.common.nix
            ./common.nix

            # CLI
            ./../../user/cli

            # Scripts
            ./../../user/scripts
            ./../../user/scripts/rebuild.nix
        ];
}
