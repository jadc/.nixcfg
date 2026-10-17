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
            version = "0.9.0";

            src = let
                arch = {
                    x86_64-linux = { name = "x86_64"; hash = "sha256-kTAMFIWtcQg5YEsIVTHJDnesfr2yowJZMJrXSvz9uQ0="; };
                    aarch64-linux = { name = "aarch64"; hash = "sha256-yVYIRERlMULdJSdM/wjbwX6L+ZgVOA239k7sAm6IL8c="; };
                }.${pkgs.stdenv.hostPlatform.system};
            in pkgs.fetchurl {
                url = "https://github.com/storytold/photocraft/releases/download/v${version}/photocraft-${version}-linux-${arch.name}.tar.gz";
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
                libxrandr
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
                description = "Open-source image editor";
                homepage = "https://github.com/storytold/photocraft";
                license = with lib.licenses; [ asl20 mit ];
                platforms = [ "x86_64-linux" "aarch64-linux" ];
                sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
                mainProgram = name;
            };
        };
    in {
        config = lib.mkIf self.enable {
            home.packages = [ package ];

            cfg.save.home.dirs = [ ".config/photocraft" ];
        };
    };
}
