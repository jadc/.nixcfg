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

    flake.modules.homeManager.${name} = { config, lib, pkgs, ... }:
    let
        self = config.cfg.${name};
        discordIgpu = pkgs.symlinkJoin {
            name = "discord-canary-igpu";
            paths = [ pkgs.discord-canary ];
            nativeBuildInputs = [ pkgs.makeWrapper ];
            postBuild = ''
                for binary in DiscordCanary discordcanary; do
                    wrapProgram "$out/bin/$binary" \
                        --set DRI_PRIME 0 \
                        --set __GLX_VENDOR_LIBRARY_NAME mesa \
                        --set __EGL_VENDOR_LIBRARY_FILENAMES /run/opengl-driver/share/glvnd/egl_vendor.d/50_mesa.json \
                        --set VK_DRIVER_FILES /run/opengl-driver/share/vulkan/icd.d/intel_icd.x86_64.json \
                        --add-flags "--disable-features=Vulkan"
                done
            '';
        };
    in {
        config = lib.mkIf self.enable {
            home.packages = [ discordIgpu ];

            cfg.save.home.dirs = [ ".config/discordcanary" ];
        };
    };
}
