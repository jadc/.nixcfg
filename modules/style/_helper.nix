{ lib }:

let
    rgbChannels = color: let
        channel = offset: lib.fromHexString (builtins.substring offset 2 color);
    in lib.concatStringsSep ", " (map (offset: toString (channel offset)) [ 0 2 4 ]);

    rgb = color: "rgb(${rgbChannels color})";
    rgba = color: opacity: "rgba(${rgbChannels color}, ${toString opacity})";

    color = default: lib.mkOption {
        inherit default;
        type = lib.types.coercedTo lib.types.str
            (value: { inherit value; })
            (lib.types.submodule ({ config, ... }: {
                options = {
                    value = lib.mkOption {
                        type = lib.types.str;
                    };
                    hex = lib.mkOption {
                        type = lib.types.str;
                        default = "#${config.value}";
                    };
                    rgb = lib.mkOption {
                        type = lib.types.str;
                        default = rgb config.value;
                    };
                    rgba = lib.mkOption {
                        type = lib.types.functionTo lib.types.str;
                        default = rgba config.value;
                    };
                };
            }));
    };
in
{
    inherit color rgb rgba;
}
