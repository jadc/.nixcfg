{
    programs.nixvim = {
        enable = true;
        defaultEditor = true;

        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;

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
            foldlevel = 20 ;                # Nested level to start folding
            foldmethod = "indent";          # Fold on indents

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
            clipboard = "unnamedplus";      # Use system clipboard
        };
    };
}
