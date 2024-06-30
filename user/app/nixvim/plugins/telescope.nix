{
    programs.nixvim.plugins.telescope = {
        enable = true;
        extensions = {
            fzf-native.enable = true;
        };

        keymaps = {
            "<C-p>" = {
                # TODO: rebind to find_files if not in git repo
                action = "git_files";
                options = {
                    desc = "Telescope Git Files";
                };
            };
            "<C-S-p>" = {
                action = "find_files";
                options = {
                    desc = "Telescope Find Files";
                };
            }; 
        };
    };
}
