{ lib, ... }:

let
    name = "xournalpp";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
