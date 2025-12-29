# Import all modules in this directory.

let
    files = builtins.readDir ./.;
    dirs = builtins.filter
        (name: files.${name} == "directory")
        (builtins.attrNames files);
in {
    imports = map (dir: ./${dir}) dirs;
}
