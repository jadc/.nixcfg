{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    buildInputs = with pkgs; [ openai-whisper ];
    shellHook = ''
        alias whisper="whisper --model large-v3 --output_format txt --task transcribe --language en"
    '';
}
