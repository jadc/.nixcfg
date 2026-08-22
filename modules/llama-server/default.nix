{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            enable = lib.mkEnableOption "llama.cpp router server for local models";

            package = lib.mkOption {
                type = lib.types.package;
                defaultText = "pkgs.llama-cpp";
                description = ''
                    llama.cpp package providing llama-server.
                    Override for GPU support, e.g.
                    pkgs.llama-cpp.override { cudaSupport = true; }
                '';
            };

            modelsDir = lib.mkOption {
                type = lib.types.path;
                default = "/data/models";
                description = "Directory of GGUF models discovered by the router.";
            };

            port = lib.mkOption {
                type = lib.types.port;
                default = 8080;
                description = "Port for the llama-server router to listen on.";
            };

            contextSize = lib.mkOption {
                type = lib.types.int;
                default = 32768;
                description = "Context window (-c) for each loaded model.";
            };

            idleTimeout = lib.mkOption {
                type = lib.types.nullOr lib.types.int;
                default = 600;
                description = ''
                    Seconds of inactivity before the router unloads a model
                    (frees GPU memory). null disables auto-unload.
                '';
            };

            openFirewall = lib.mkOption {
                type = lib.types.bool;
                default = false;
                description = "Open the port on the firewall (default: local-only).";
            };
        };
    };

    flake.modules.nixos.${name} = { config, lib, pkgs, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            cfg.${name}.package = lib.mkDefault pkgs.llama-cpp;

            environment.systemPackages = [ self.package ];

            users.groups.llama-server = {};
            users.users.llama-server = {
                isSystemUser = true;
                group = "llama-server";
            };

            systemd.tmpfiles.rules = [
                "d ${self.modelsDir} 0775 jad llama-server"
            ];

            systemd.services.llama-server = {
                after = [ "network.target" ];
                wantedBy = [ "multi-user.target" ];
                environment.HF_HOME = "/var/lib/llama-server/hf";
                serviceConfig = {
                    Type = "simple";
                    User = "llama-server";
                    Group = "llama-server";
                    StateDirectory = "llama-server";
                    Restart = "on-failure";
                    # Router mode: no --model, models load on demand.
                    ExecStart = lib.concatStringsSep " \\\n    " ([
                        "${self.package}/bin/llama-server"
                        "--models-dir ${self.modelsDir}"
                        "--no-models-autoload"
                        "--jinja"
                        "--host 0.0.0.0"
                        "--port ${toString self.port}"
                        "-ngl 999"
                        "-c ${toString self.contextSize}"
                    ] ++ lib.optionals (self.idleTimeout != null) [
                        "--timeout ${toString self.idleTimeout}"
                    ]);
                };
            };

            networking.firewall.allowedTCPPorts = lib.optionals self.openFirewall [ self.port ];

            cfg.save.root.dirs = [ "${self.modelsDir}" ];
        };
    };
}
