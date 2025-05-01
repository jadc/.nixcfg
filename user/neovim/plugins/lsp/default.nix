{ pkgs, ... }:

{
    programs.neovim.plugins = with pkgs.vimPlugins; [
        nvim-cmp
        nvim-lspconfig
        cmp-buffer
        cmp-nvim-lsp
        cmp-path
        lsp_lines-nvim
        lspkind-nvim
        luasnip
        friendly-snippets
        cmp_luasnip
    ];
    xdg.configFile."nvim/after/plugin/cmp.lua".source = ./cmp.lua;
    xdg.configFile."nvim/after/plugin/lsp.lua".source = ./lsp.lua;

    # Language Servers
    home.packages = with pkgs; [
        bash-language-server
        clang-tools
        cmake-language-server
        eslint
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
}
