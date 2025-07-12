{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    buildInputs = [
        (pkgs.whisper-cpp.override { cudaSupport = true; })
        pkgs.cudaPackages.cuda_cudart
        pkgs.cudaPackages.cuda_nvcc
        pkgs.cudaPackages.cudatoolkit
    ];

    shellHook = ''
        export CUDA_PATH=${pkgs.cudaPackages.cudatoolkit}
        export PATH=$CUDA_PATH/bin:$PATH
        export LIBRARY_PATH=$CUDA_PATH/lib:$LIBRARY_PATH
        export LD_LIBRARY_PATH=$CUDA_PATH/lib:/run/opengl-driver/lib:/run/opengl-driver-32:$LD_LIBRARY_PATH
    '';
}
