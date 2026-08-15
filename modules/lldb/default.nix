{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            enable = lib.mkEnableOption name;
        };
    };

    flake.modules.homeManager.${name} = { config, lib, pkgs, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            home.packages = [ pkgs.lldb ];

            home.file.".lldbinit".text = ''
                # Use C++ syntax and name lookup for expressions by default.
                settings set target.language c++

                # Display x86 assembly in Intel rather than AT&T syntax.
                settings set target.x86-disassembly-flavor intel

                # Do not automatically show assembly when execution stops.
                settings set stop-disassembly-display never

                # Accept LLDB confirmation prompts automatically.
                settings set auto-confirm true
            '';
        };
    };
}
