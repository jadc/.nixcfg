{ pkgs, ... }:

# This assumes you already have NVIDIA drivers installed.

let
    cuda = pkgs.cudaPackages.cudatoolkit;
in
{
    home.packages = [ cuda ];

    home.sessionVariables = {
        CUDA_PATH = "${cuda}";
        LIBRARY_PATH = "${cuda}/lib:$LIBRARY_PATH";
        LD_LIBRARY_PATH = "${cuda}/lib:/run/opengl-driver/lib:/run/opengl-driver-32:$LD_LIBRARY_PATH";
    };

    home.sessionPath = [
        "${cuda}/bin"
    ];
}
