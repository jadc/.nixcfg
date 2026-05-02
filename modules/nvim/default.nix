{ inputs, ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.homeManager.${name} = {
        imports = [ inputs.nvim.homeManagerModules.default ];

        # Plugin install dir and runtime state (undo, swap, …)
        cfg.impermanence.home.dirs = [
            ".local/share/nvim"
            ".local/state/nvim"
        ];
    };
}
