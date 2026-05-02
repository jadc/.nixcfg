{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    buildInputs = [
        pkgs.ghostscript
        (pkgs.texlive.combine {
            inherit (pkgs.texlive) scheme-basic
            collection-latex
            collection-latexrecommended
            collection-latexextra
            collection-luatex
            collection-fontsrecommended
            collection-fontsextra;
        })
    ];
}
