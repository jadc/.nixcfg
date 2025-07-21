{ pkgs ? import <nixpkgs> {} }:

let
    target = pkgs._2ship2harkinian;
in
pkgs.mkShell {
    buildInputs = [ target ];
    shellHook = ''${target}/bin/2s2h'';
}
