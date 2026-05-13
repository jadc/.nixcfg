{
    inputs = {
        nixpkgs = {
            url = "github:NixOS/nixpkgs/nixos-unstable";
        };

        flake-parts = {
            url = "github:hercules-ci/flake-parts";
        };

        import-tree = {
            url = "github:vic/import-tree";
        };

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        preservation = {
            url = "github:nix-community/preservation";
        };

        nvim = {
            url = "github:jadc/nvim";
        };

        noctalia = {
            url = "github:noctalia-dev/noctalia-shell";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        stylix = {
            url = "github:nix-community/stylix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs:
        inputs.flake-parts.lib.mkFlake { inherit inputs; } {
            systems = inputs.nixpkgs.lib.systems.flakeExposed;
            imports = [
                inputs.flake-parts.flakeModules.modules
                ./profiles
                (inputs.import-tree ./modules)
            ];
        };
}
