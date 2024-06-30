{
    programs.nixvim.plugins.gitsigns = {
        enable = true;

        settings = {
            signcolumn = true;
            numhl = true;
            word_diff = true;
        };
    };
}
