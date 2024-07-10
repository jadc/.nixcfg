{
    programs.nixvim.plugins.treesitter = {
        enable = true;
        folding = true;
        settings.indent.enable = true;
        nixvimInjections = true;
    };
}
