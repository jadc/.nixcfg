{ config, lib, pkgs, ... }:

let
    name = "neovim";
    self = config.cfg.user.${name};
in
{
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

        # Install all required packages
        home.packages = with pkgs; [
            fd
            fzf
            gcc
            gnumake
            ripgrep
            tree-sitter
            wl-clipboard
            xclip

            # Language Servers
            bash-language-server
            clang-tools
            clippy
            gopls
            lua-language-server
            nixd
            pyright
            rust-analyzer
            svelte-language-server
            typescript-language-server
            vscode-langservers-extracted
            yaml-language-server
        ];
    };
}
