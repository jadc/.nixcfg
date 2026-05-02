{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    buildInputs = [
        pkgs.libimobiledevice
        pkgs.ifuse
        pkgs.usbmuxd
    ];
}
