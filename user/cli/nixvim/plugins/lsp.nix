{
    programs.nixvim.plugins = {
        lsp = {
            enable = true;

            servers = {
                # C/C++
                clangd = {
                    enable = true;
                    cmd = ["clangd" "--background-index" "--clang-tidy"];
                };
                cmake.enable = true;

                # Go
                gopls.enable = true;

                # Lua
                lua_ls = {
                    enable = true;
                    settings.telemetry.enable = false;
                };

                # Nix
                nixd.enable = true;

                # C#
                omnisharp.enable = true;

                # Python
                pyright.enable = true;

                # Rust
                rust_analyzer = {
                    enable = true;
                    installCargo = true;
                    installRustc = true;
                };

                # Web Development
                cssls.enable = true;
                eslint.enable = true;
                html.enable = true;
                svelte.enable = true;
                ts_ls.enable = true;

                # Misc
                jsonls.enable = true;
                bashls.enable = true;
            };
        };
        lspkind.enable = true;
        lsp-lines.enable = true;

        cmp = {
            enable = true;
            autoEnableSources = true;

            settings = {
                sources = [
                    { name = "nvim_lsp"; }
                    { name = "path";     }
                    { name = "buffer";   }
                    { name = "luasnip";  }
                    { name = "copilot";  }
                ];

                # Suggestion dropdown styling
                window.completion = {
                    border = "rounded";
                };

                # Do not automatically select from complete dropdown
                preselect = "cmp.PreselectMode.None";

                mapping = {
                    "<C-Space>" = "cmp.mapping.complete()";
                    "<CR>" = "cmp.mapping.confirm({ select = true })";
                    "<Tab>" = ''
                        cmp.mapping(function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item()
                            elseif require("luasnip").expand_or_locally_jumpable() then
                                require("luasnip").expand_or_jump()
                            elseif has_words_before() then
                                cmp.complete()
                            else
                                fallback()
                            end
                        end, { "i", "s" })
                    '';
                    "<S-Tab>" = "cmp.mapping.select_prev_item()";
                };
            };
        };

        # For some reason, autoEnableSources doesn't do this
        cmp-nvim-lsp.enable = true;
        cmp-buffer.enable = true;
        cmp-path.enable = true;
        luasnip.enable = true;

        # Copilot setup
        copilot-lua = {
            enable = true;
            settings = {
                suggestion.enabled = false;
                panel.enabled = false;
            };
        };
        copilot-cmp.enable = true;
    };

    programs.nixvim = {
        # Extra LSP config
        extraConfigLuaPre = ''
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            require("luasnip.loaders.from_vscode").lazy_load()
        '';

        # Dropdown menu LSP actions
        extraConfigLuaPost = ''
            vim.cmd.amenu([[PopUp.Info <Cmd>lua vim.lsp.buf.hover()<CR>]])
            vim.cmd.amenu([[PopUp.Definition <Cmd>lua vim.lsp.buf.definition()<CR>]])
            vim.cmd.amenu([[PopUp.Usages <Cmd>lua vim.lsp.buf.references()<CR>]])
            vim.cmd.amenu([[PopUp.Refactor <Cmd>lua vim.lsp.buf.rename()<CR>]])
            vim.cmd.amenu([[PopUp.Error <Cmd>lua vim.diagnostic.open_float()<CR>]])
        '';
    };
}
