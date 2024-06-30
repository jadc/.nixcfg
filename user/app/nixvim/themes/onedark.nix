{
    programs.nixvim.colorschemes.onedark = {
        enable = true;
        settings = {
            style = "deep";
            # Saturated by 25% (except marked)
            colors = {
                bg0 = "#000000";
                bg1 = "#000000";
                bg2 = "#000000";
                bg3 = "#000000";
                fg = "#dde0e5";      #
                /*
                red = "#f3556c";
                orange = "#dc9a5b";
                yellow = "#ebc274";
                green = "#81d76b";
                cyan = "#20c3d0";
                blue = "#5daff3";
                purple = "#dc57e6";
                white = "#dde0e5";   #
                black = "#282c34";
                gray = "#5c6370";    #
                highlight = "#e2be7d";
                comment = "#7f848e";
                none = "NONE";
                */
            };
        };
    };
}
