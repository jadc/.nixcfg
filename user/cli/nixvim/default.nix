{ inputs, ... }:

{
    imports = [
        inputs.nixvim.homeManagerModules.nixvim

        ./options.nix
        ./mappings.nix

        # Themes
        ./themes/onedark.nix

        # Plugins
        ./plugins/barbar.nix
        ./plugins/gitsigns.nix
        ./plugins/lsp.nix
        ./plugins/telescope.nix
        ./plugins/treesitter.nix
    ];

    programs.nixvim = {
        enable = true;
        defaultEditor = true;

        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
    };
}
