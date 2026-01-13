{ config, lib, ... }:

let
    name = "neovim";
    self = config.cfg.user.${name};
in
{
    imports = [
        # Theme
        ./themes/onedark

        # Plugins
        ./plugins/barbar
        ./plugins/cmp
        ./plugins/flash
        ./plugins/gitsigns
        ./plugins/lsp
        ./plugins/mini-cursorword
        ./plugins/mini-trailspace
        ./plugins/rainbow
        ./plugins/telescope
        ./plugins/treesitter
        ./plugins/visual-whitespace

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

    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
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
    };
}
