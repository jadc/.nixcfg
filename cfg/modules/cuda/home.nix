{ config, lib, pkgs, ... }:

let
    name = "cuda";
    self = config.cfg.user.${name};
    cuda = pkgs.cudaPackages.cudatoolkit;
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        # This assumes you already have NVIDIA drivers installed.
        home.packages = [ cuda ];

        home.sessionVariables = {
            CUDA_PATH = "${cuda}";
            LIBRARY_PATH = "${cuda}/lib:$LIBRARY_PATH";
            LD_LIBRARY_PATH = "${cuda}/lib:/run/opengl-driver/lib:/run/opengl-driver-32:$LD_LIBRARY_PATH";
        };

        home.sessionPath = [
            "${cuda}/bin"
        ];
    };
}
