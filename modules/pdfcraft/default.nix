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

        # Prebuilt upstream release binaries (not in nixpkgs).
        package = pkgs.stdenv.mkDerivation rec {
            pname = name;
            version = "0.8.0";

            src = let
                arch = {
                    x86_64-linux = { name = "x86_64"; hash = "sha256-P0/V3dmYAqPTSUdMYc89q9H7cZjqDfANJMwxBRa9HCo="; };
                    aarch64-linux = { name = "aarch64"; hash = "sha256-SOGAyIllEu0bEIkrr5WnXfS72Gb3IFFQZiy0faKkv5c="; };
                }.${pkgs.stdenv.hostPlatform.system};
            in pkgs.fetchurl {
                url = "https://github.com/storytold/pdfcraft/releases/download/v${version}/pdfcraft-${version}-linux-${arch.name}.tar.gz";
                inherit (arch) hash;
            };

            nativeBuildInputs = [ pkgs.autoPatchelfHook pkgs.makeWrapper ];
            buildInputs = [ pkgs.stdenv.cc.cc.lib ];

            # Loaded via dlopen at runtime; the binary also checks for them
            # through LD_LIBRARY_PATH before starting.
            runtimeLibs = with pkgs; [
                dbus
                libGL
                libxkbcommon
                vulkan-loader
                wayland
                libx11
                libxcursor
                libxi
                libxrender
                libxcb
            ];

            dontConfigure = true;
            dontBuild = true;

            installPhase = ''
                runHook preInstall
                mkdir -p $out
                cp -r bin share $out/
                runHook postInstall
            '';

            postFixup = ''
                for bin in $out/bin/*; do
                    wrapProgram $bin --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath runtimeLibs}
                done
            '';

            meta = {
                description = "Open-source PDF workbench";
                homepage = "https://github.com/storytold/pdfcraft";
                license = with lib.licenses; [ asl20 mit ];
                platforms = [ "x86_64-linux" "aarch64-linux" ];
                sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
                mainProgram = name;
            };
        };
    in {
        config = lib.mkIf self.enable {
            home.packages = [ package ];

            cfg.save.home.dirs = [ ".local/share/pdfcraft" ];
        };
    };
}
