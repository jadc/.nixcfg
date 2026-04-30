# Loads each module (options.nix and default.nix) for NixOS configuration.

let
    files = builtins.readDir ./.;
    dirs = builtins.filter
        (name: files.${name} == "directory")
        (builtins.attrNames files);
    hasOptions = dir: builtins.pathExists ./${dir}/options.nix;
    hasDefault = dir: builtins.pathExists ./${dir}/default.nix;
in {
    imports =
        (map (dir: ./${dir}/options.nix) (builtins.filter hasOptions dirs))
        ++ (map (dir: ./${dir}) (builtins.filter hasDefault dirs));
}
