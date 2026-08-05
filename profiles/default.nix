{ ... }: {
    imports = let
        entries = builtins.readDir ./.;
        isProfile = n: entries.${n} == "directory" && builtins.substring 0 1 n != "_";
        profiles = builtins.filter isProfile (builtins.attrNames entries);
    in map (p: ./. + "/${p}") profiles;
}
