{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            enable = lib.mkEnableOption name;
        };
    };

    flake.modules.homeManager.${name} = { config, lib, pkgs, ... }: let
        self = config.cfg.${name};

        # Unpatched upstream binary. It runs inside the Unity Hub FHS env, so
        # the editors it spawns find their libraries (libGL, etc.).
        unity-cli-unwrapped = pkgs.stdenv.mkDerivation rec {
            pname = "unity-cli-unwrapped";
            version = "1.0.1";

            src = let
                arch = {
                    x86_64-linux = { name = "x64"; hash = "sha256-o451Yx7d5blt+OCjfi64yNHrGmujD9QcNPK6rHk7WzE="; };
                    aarch64-linux = { name = "arm64"; hash = "sha256-vTo5m6HlqogwNmjF2IrY4LGBT71XhKSQ4fUwSIJpLr4="; };
                }.${pkgs.stdenv.hostPlatform.system};
            in pkgs.fetchurl {
                url = "https://public-cdn.cloud.unity3d.com/hub/prod/cli/${version}/unity-linux-${arch.name}";
                inherit (arch) hash;
            };

            dontUnpack = true;
            dontConfigure = true;
            dontBuild = true;
            dontStrip = true;

            installPhase = ''
                runHook preInstall
                install -Dm755 $src $out/bin/unity
                runHook postInstall
            '';
        };

        # Run the CLI in the same FHS env as Unity Hub. That env also provides
        # libsecret (dlopened for credential storage). Updates come from this
        # derivation, so disable the self-update check.
        unity-cli = pkgs.runCommand "unity-cli-${unity-cli-unwrapped.version}" {
            nativeBuildInputs = [ pkgs.makeWrapper ];
            inherit (unity-cli-unwrapped) version;
            meta.mainProgram = "unity";
        } ''
            makeWrapper ${pkgs.unityhub.fhsEnv}/bin/unityhub-fhs-env $out/bin/unity \
                --add-flags ${unity-cli-unwrapped}/bin/unity \
                --set-default UNITY_NO_UPDATE_CHECK 1
        '';
    in {
        config = lib.mkIf self.enable {
            home.packages = [ pkgs.unityhub unity-cli ];

            cfg.save.home.dirs = [
                ".config/unity3d"
                ".config/unityhub"
                ".config/UnityHub"
                ".local/share/unity3d"
            ];
        };
    };
}
