{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    buildInputs = with pkgs; [
        ghostscript
        (texlive.combine {
            inherit (texlive) scheme-basic
            collection-latex
            collection-latexrecommended
            collection-latexextra
            collection-luatex
            collection-fontsrecommended
            collection-fontsextra;
        })
    ];
}
