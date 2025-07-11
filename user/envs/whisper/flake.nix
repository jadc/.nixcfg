{
    # This flake assumes you already have NVIDIA drivers installed.

    inputs = {
        nixpkgs.url = "nixpkgs/nixpkgs-unstable";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs, flake-utils }:
        flake-utils.lib.eachDefaultSystem (system:
            let
                pkgs = import nixpkgs {
                    inherit system;
                    config.allowUnfree = true;
                };
            in {
                devShells.default = pkgs.mkShell {
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
                };
            });
}
