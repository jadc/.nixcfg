# Loads each module (options.nix and home.nix) for home-manager configuration.

let
    files = builtins.readDir ./.;
    dirs = builtins.filter
        (name: files.${name} == "directory")
        (builtins.attrNames files);
    hasOptions = dir: builtins.pathExists ./${dir}/options.nix;
    hasHome = dir: builtins.pathExists ./${dir}/home.nix;
in {
    imports =
        (map (dir: ./${dir}/options.nix) (builtins.filter hasOptions dirs))
        ++ (map (dir: ./${dir}/home.nix) (builtins.filter hasHome dirs));
}
