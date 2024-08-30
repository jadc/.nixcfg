# noxide: frequency cd

{
    programs.zoxide = {
        enable = true;

        # Replace cd with zoxide
        options = [ "--cmd cd" ];
    };
}
