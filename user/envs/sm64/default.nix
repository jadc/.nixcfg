{ pkgs ? import <nixpkgs> {} }:

let
    sm64baserom = pkgs.runCommand "baserom-us-safety-dir" { } ''
        mkdir $out
        ln -s ${./baserom.us.z64} $out/baserom.us.z64
    '' // {
        romPath = "${sm64baserom.outPath}/baserom.us.z64";
        override = _: sm64baserom;
    };
    sm64 = pkgs.sm64coopdx.override { inherit sm64baserom; };
in
pkgs.mkShell {
    buildInputs = [ sm64 ];
    shellHook = ''${sm64}/bin/sm64coopdx'';
}
