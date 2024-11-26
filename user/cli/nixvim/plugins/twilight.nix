{
    programs.nixvim.plugins.twilight = {
        enable = true;
        settings = {
            context = 20;
            expand = [
                "function"
                "method"
            ];
        };
    };
}
