setup_server(
    "clangd", {
        cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--limit-results=0",
            "--log=verbose"
        },
        init_options = {
            fallbackFlags = { "-std=c++11" },
        },
    }
)
