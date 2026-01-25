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

        # Desktop entry for kitty+neovim
        xdg.desktopEntries.nvim = {
            name = "Neovim";
            genericName = "Text Editor";
            exec = "${pkgs.kitty}/bin/kitty -e nvim %F";
            terminal = false;
            categories = [ "Utility" "TextEditor" ];
            mimeType = [ "text/plain" ];
        };

        # Set as default text editor
        xdg.mimeApps.defaultApplications = {
            "text/plain" = "nvim.desktop";
            "text/markdown" = "nvim.desktop";
            "text/x-csrc" = "nvim.desktop";
            "text/x-chdr" = "nvim.desktop";
            "text/x-python" = "nvim.desktop";
            "text/x-shellscript" = "nvim.desktop";
            "text/x-java" = "nvim.desktop";
            "text/xml" = "nvim.desktop";
            "application/json" = "nvim.desktop";
            "application/x-yaml" = "nvim.desktop";
            "application/toml" = "nvim.desktop";
            "application/x-shellscript" = "nvim.desktop";
        };
    };
}
