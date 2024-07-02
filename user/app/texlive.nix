{ config, ... }:

{
    config = {
        programs.texlive = {
            enable = true;
            # TODO: add more packages as needed
        };

        common.aliases.texview = "latexmk -pdf -pvc *.tex";
    };
}
