{
    programs.nixvim.keymaps = [
        # Disable arrow keys
        { 
            key = "<Up>"; 
            mode = [ "n" "x" "i" ];
            action = "<Nop>"; 
        }
        { 
            key = "<Down>"; 
            mode = [ "n" "x" "i" ];
            action = "<Nop>"; 
        }
        { 
            key = "<Left>"; 
            mode = [ "n" "x" "i" ];
            action = "<Nop>"; 
        }
        { 
            key = "<Right>"; 
            mode = [ "n" "x" "i" ];
            action = "<Nop>"; 
        }

        # Allow movement through wrapped lines
        { 
            key = "j"; 
            mode = [ "n" "x" ];
            action = "gj"; 
        }
        { 
            key = "k"; 
            mode = [ "n" "x" ];
            action = "gk"; 
        }
        {
            key = "$";
            mode = [ "n" "x" ];
            action = "g$";
        }
        {
            key = "0";
            mode = [ "n" "x" ];
            action = "g0";
        }
    ];
}
