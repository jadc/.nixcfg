{ pkgs, ... }:

{
    # Set default shell to zsh for all users
    environment.shells = with pkgs; [ zsh ];
    users.defaultUserShell = pkgs.zsh;
    programs.zsh.enable = true;
}
