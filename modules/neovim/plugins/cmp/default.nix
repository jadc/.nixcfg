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
    xdg.configFile."nvim/after/plugin/cmp.lua".source = ./init.lua;
}
