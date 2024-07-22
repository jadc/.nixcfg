{
    imports = 
        [
            # Standard configuration
            ./../home.common.nix
            ./common.nix

            # CLI
            ./../../user/cli/shells.nix
            ./../../user/cli/git.nix
            ./../../user/cli/zoxide.nix
            ./../../user/cli/eza.nix
            ./../../user/cli/fzf.nix
            ./../../user/cli/nixvim
            ./../../user/cli/tmux.nix
            ./../../user/cli/archivers.nix
            ./../../user/cli/rsync.nix
            ./../../user/cli/ripgrep.nix
        ];
}
