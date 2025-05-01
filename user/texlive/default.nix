{ pkgs, ... }:

{
    programs.texlive = {
        enable = true;
        extraPackages = tpkgs: {
            inherit (tpkgs) collection-basic;
            inherit (tpkgs) collection-latex;
            inherit (tpkgs) collection-latexrecommended;
            inherit (tpkgs) collection-latexextra;
            inherit (tpkgs) collection-luatex;
            inherit (tpkgs) collection-fontsrecommended;
            inherit (tpkgs) collection-fontsextra;
        };
    };
    home.packages = with pkgs; [ ghostscript ];
    # common.aliases.texview = "latexmk -pdf -pvc *.tex";
    common.aliases.texview = "pdflatex *.tex";
}
