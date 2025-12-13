{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

pkgs.mkShell {
    buildInputs = with pkgs; [
        python3
        (python3.withPackages (ps: with ps; [ torchWithCuda ]))
        cudaPackages.cudatoolkit
        cudaPackages.cudnn
        cudaPackages.cuda_cudart
        gcc13

        openai-whisper
    ];

    shellHook = ''
        export CUDA_PATH=${pkgs.cudatoolkit}
        export CC=${pkgs.gcc13}/bin/gcc
        export CXX=${pkgs.gcc13}/bin/g++
        export PATH=${pkgs.gcc13}/bin:$PATH
        export LD_LIBRARY_PATH=${
            pkgs.lib.makeLibraryPath [
                "/run/opengl-driver"
                pkgs.cudaPackages.cudatoolkit
                pkgs.cudaPackages.cudnn
            ]
        }:$LD_LIBRARY_PATH
        export LIBRARY_PATH=${
            pkgs.lib.makeLibraryPath [
                pkgs.cudaPackages.cudatoolkit
            ]
        }:$LIBRARY_PATH

        alias whisper="whisper --model turbo --output_format txt --task transcribe --language en"
    '';
}
