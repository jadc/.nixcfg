{
    # Allow unfree packages in nix shells
    xdg.configFile."nixpkgs/config.nix".text = ''{ allowUnfree = true; }'';
}
