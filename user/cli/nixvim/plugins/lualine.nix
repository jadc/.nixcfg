{
    programs.nixvim.plugins.lualine = {
        enable = true;

        # Set background color to black
        theme = {
            normal = {
                c = { bg = "#000000"; };
            };
        };
    };
}
