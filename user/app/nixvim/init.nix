{
    imports = [
        ./options.nix
        ./mappings.nix

        # Themes
        ./themes/onedark.nix

        # Plugins
        ./plugins/treesitter.nix
        ./plugins/telescope.nix
        ./plugins/gitsigns.nix
    ];

    programs.nixvim = {
        enable = true;
        defaultEditor = true;

        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
    };
}
