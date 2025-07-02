{
    imports = [
        # Theme
        ./themes/onedark

        # Plugins
        ./plugins/barbar
        ./plugins/cmp
        ./plugins/gitsigns
        ./plugins/lsp
        ./plugins/mini-jump2d
        ./plugins/mini-pairs
        ./plugins/mini-trailspace
        ./plugins/telescope
        ./plugins/treesitter

        # Language Servers
        ./plugins/lsp/bash
        ./plugins/lsp/c
        ./plugins/lsp/go
        ./plugins/lsp/lua
        ./plugins/lsp/nix
        ./plugins/lsp/python
        ./plugins/lsp/rust
        ./plugins/lsp/svelte
        ./plugins/lsp/typescript
        ./plugins/lsp/web
        ./plugins/lsp/yaml
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
