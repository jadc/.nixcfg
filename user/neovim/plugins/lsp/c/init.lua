setup_server(
    "clangd", {
        cmd = { "clangd", "--background-index", "--clang-tidy" },
    }
)
