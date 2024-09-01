{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
        jetbrains.clion
        cmake
        ninja
    ];

    home.sessionVariables = let
        root = "${config.common.home}/Documents/cmput415";
        ANTLR_PARENT = "${root}/antlr";
        ANTLR_INS="${ANTLR_PARENT}/antlr4-install";
        ANTLR_BIN="${ANTLR_INS}/bin";
        ANTLR_JAR="${ANTLR_BIN}/antlr-4.13.0-complete.jar";

        MLIR_INS="${root}/llvm-project/build";
        MLIR_DIR="${MLIR_INS}/lib/cmake/mlir/";
    in {
        ANTLR_PARENT = "${ANTLR_PARENT}";
        ANTLR_INS="${ANTLR_INS}";
        ANTLR_BIN="${ANTLR_BIN}";
        ANTLR_JAR="${ANTLR_JAR}";
        CLASSPATH="${ANTLR_JAR}:$CLASSPATH";

        MLIR_INS="${MLIR_INS}";
        MLIR_DIR="${MLIR_DIR}";
    };

    home.sessionPath = let 
        root = "${config.common.home}/Documents/cmput415";
    in [
        "${root}/llvm-project/build/bin"
        "${root}/Tester/bin"
    ];

    common.aliases = {
        antlr4 = "${pkgs.jdk}/bin/java -Xmx500M org.antlr.v4.Tool";
        grun = "${pkgs.jdk}/bin/java org.antlr.v4.gui.TestRig";
    };
}
