{ pkgs, ... }:

let
    shellAliases = {
        cat = "bat";
    };
in
{
    programs.zsh = {
        enable = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        enableCompletion = true;
        inherit shellAliases;
    };
}
