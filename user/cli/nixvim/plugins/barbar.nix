{
    programs.nixvim.plugins.barbar = {
        enable = true;

        settings = {
            # Hide tab bar when there is at most one tab
            # auto_hide = 1;
        };

        keymaps = {
            previous        = { key = "<c-h>";   };
            next            = { key = "<c-l>";   };
            restore         = { key = "<c-s-t>"; };
            movePrevious    = { key = "<c-s-h>"; };
            moveNext        = { key = "<c-s-l>"; };
            pick            = { key = "<c-t>";   };
        };
    };

    # Dependency
    programs.nixvim.plugins.web-devicons.enable = true;

    # C-w is an existing mapping, so must map outside barbar
    # in order to use nowait flag
    programs.nixvim.keymaps = [
        {
            action = "<Cmd>BufferClose<CR>";
            key = "<c-w>";
            mode = "n";
            options = {
                nowait = true;
            };
        }
    ];
}
