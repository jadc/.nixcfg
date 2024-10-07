{
    imports = 
        [
            # Standard configuration
            ./../home.common.nix
            ./common.nix

            # CLI
            ./../../user/cli/shells
            ./../../user/cli/git
            ./../../user/cli/zoxide
            ./../../user/cli/eza
            ./../../user/cli/fzf
            ./../../user/cli/nixvim
            ./../../user/cli/tmux
            ./../../user/cli/archivers
            ./../../user/cli/rsync
            ./../../user/cli/ripgrep

            # Scripts
            ./../../user/scripts
            ./../../user/scripts/rebuild.nix
        ];
}
