{ pkgs, ... }:

{
    home.packages = with pkgs; [ openai-whisper ];
}
