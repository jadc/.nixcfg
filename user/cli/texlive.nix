{ config, pkgs, ... }:

{
    config = {
        programs.texlive.enable = true;
        common.aliases.texview = "latexmk -pdf -pvc *.tex";
    };
}
