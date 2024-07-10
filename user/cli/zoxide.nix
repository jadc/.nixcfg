# noxide: frequency cd

{
    programs.zoxide = {
        enable = true;

        # Prevent creation of z and zi commands
        options = [ "--no-cmd" ];

        # Replace cd with zoxide
        # TODO: figure out how to do that :p
    };
}
