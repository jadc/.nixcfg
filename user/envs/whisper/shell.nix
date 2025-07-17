{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    buildInputs = with pkgs; [
        openai-whisper
        cudaPackages.cuda_cudart
        cudaPackages.cuda_nvcc
        cudaPackages.cudatoolkit
    ];

    shellHook = ''
        export CUDA_PATH=${pkgs.cudaPackages.cudatoolkit}
        export PATH=$CUDA_PATH/bin:$PATH
        export LIBRARY_PATH=$CUDA_PATH/lib:$LIBRARY_PATH
        export LD_LIBRARY_PATH=$CUDA_PATH/lib:/run/opengl-driver/lib:/run/opengl-driver-32:$LD_LIBRARY_PATH
    '';
}
