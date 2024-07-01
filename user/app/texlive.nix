{ common, ... }:

{
    programs.texlive = {
        enable = true;
        # TODO: add more packages as needed
    };

    # TODO: make this work
    # common.aliases.texview = "latexmk -pdf -pvc *.tex";
}
