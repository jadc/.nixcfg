# Imports only home-manager configurations (for non-NixOS systems)

let
    files = builtins.readDir ./.;
    dirs = builtins.filter
        (name: files.${name} == "directory")
        (builtins.attrNames files);
in {
    imports = builtins.map (dir: ./${dir}/home.nix) dirs;
}
