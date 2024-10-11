{
    programs.nixvim = {
        plugins.telescope = {
            enable = true;

            # Telescope keymaps
            keymaps."<C-f>".action = "live_grep";
        };
        plugins.web-devicons.enable = true;

        # Regular neovim keymaps
        keymaps = [
            {
                key = "<C-p>";
                action = "<Cmd>lua project_files()<CR>";
                options = {
                    desc = "Telescope Git Files";
                };
            }
        ];

        extraConfigLuaPre = ''
            local is_inside_work_tree = {}
            _G.project_files = function()
                local opts = {}
                local cwd = vim.fn.getcwd()
                if is_inside_work_tree[cwd] == nil then
                    vim.fn.system("git rev-parse --is-inside-work-tree")
                    is_inside_work_tree[cwd] = vim.v.shell_error == 0
                end
                if is_inside_work_tree[cwd] then
                    require("telescope.builtin").git_files(opts)
                else
                    require("telescope.builtin").find_files(opts)
                end
            end
        '';
    };
}
