{ ... }: {
    imports = let
        entries = builtins.readDir ./.;
        profiles = builtins.filter (n: entries.${n} == "directory") (builtins.attrNames entries);
    in map (p: ./. + "/${p}") profiles;
}
