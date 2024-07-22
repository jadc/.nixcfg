{ inputs, ... }:

{
    imports = [
        inputs.nixvim.homeManagerModules.nixvim

        ./options.nix
        ./mappings.nix

        # Themes
        ./themes/onedark.nix

        # Plugins
        ./plugins/treesitter.nix
        ./plugins/telescope.nix
        ./plugins/gitsigns.nix
        ./plugins/barbar.nix
        ./plugins/lsp.nix
    ];

    programs.nixvim = {
        enable = true;
        defaultEditor = true;

        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
    };
}
