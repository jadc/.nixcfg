{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    buildInputs = with pkgs; [
        libimobiledevice
        ifuse
        usbmuxd
    ];
}
