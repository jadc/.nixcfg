{
    imports = [
        ./themes/onedark
        ./plugins/barbar
        ./plugins/gitsigns
        ./plugins/telescope
        ./plugins/treesitter
        ./plugins/lsp
    ];

    programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
    };

    # Copy Lua config to /nix/store, and link to it
    xdg.configFile.nvim = {
        source = ./config;
        recursive = true;
    };
}
