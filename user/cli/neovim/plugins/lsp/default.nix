{ pkgs, ... }:

{
    programs.neovim.plugins = with pkgs.vimPlugins; [
        nvim-lspconfig
        nvim-cmp

        cmp-buffer
        cmp-nvim-lsp
        cmp-path
        lsp_lines-nvim
        lspkind-nvim
        luasnip
    ];
    xdg.configFile."nvim/after/plugin/lsp.lua".source = ./lsp.lua;
    xdg.configFile."nvim/after/plugin/cmp.lua".source = ./cmp.lua;

    # Language servers
    home.packages = with pkgs; [
        typescript-language-server
        svelte-language-server
        rust-analyzer
        pyright
        omnisharp-roslyn
        nixd
        lua-language-server
        vscode-langservers-extracted
        gopls
        eslint
        cmake-language-server
        clang-tools
        bash-language-server
    ];
}
