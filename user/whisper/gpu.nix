{ pkgs, ... }:

{
    home.packages = with pkgs; [ openai-whisper ];
    common.aliases.whisper = "${pkgs.openai-whisper}/bin/whisper --model turbo --output_format txt --task transcribe --language en $@";
}
