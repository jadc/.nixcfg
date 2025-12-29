# Imports only home-manager configurations (for non-NixOS systems)

let
    files = builtins.readDir ./.;
    dirs = builtins.filter
        (name: files.${name} == "directory")
        (builtins.attrNames files);
    hasHome = builtins.filter
        (dir: builtins.pathExists ./${dir}/home.nix)
        dirs;
in {
    imports = map (dir: ./${dir}/home.nix) hasHome;
}
