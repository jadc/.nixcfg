{
    programs.nixvim = {
        # Options
        clipboard.register = "unnamedplus"; # Use system clipboard
        opts = {
            # Indentation
            tabstop = 4;                    # Tab size
            softtabstop = 4;                # Cursed tab size
            shiftwidth = 4;                 # Indent key amount
            expandtab = true;               # Tabs as spaces
            breakindent = true;             # Maintain indent when wrapping
            linebreak = true;               # Don't cut words while wrapping
            shiftround = true;              # Might not be needed
            copyindent = true;              # Might not be needed
            foldlevel = 20;                 # Nested level to start folding

            # Disable backups
            backup = false;
            writebackup = false;
            swapfile = false;               # No swap files
            undofile = false;               # No undo files

            # Misc.
            number = true;                  # Line numbers
            ignorecase = true;              # Case insensitive search
            smartcase = true;               # Sensitive if search has caps
            hlsearch = false;               # Removes search highlight
            cmdheight = 0;                  # No command line height
            laststatus = 0;                 # No status line
        };

        # Highlight trailing whitespace
        highlight.ExtraWhitespace.bg = "red";
        match.ExtraWhitespace = "\\s\\+$";

        extraConfigLua = ''
            -- Remove weird dropdown option
            vim.cmd.aunmenu([[PopUp.How-to\ disable\ mouse]])
        '';
    };
}
