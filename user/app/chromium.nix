{
    programs.chromium = {
        enable = true;

        commandLineArgs = [
            "--ignore-gpu-blacklist"
        ];

        extensions = [
            # uBlock Origin
            { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }

            # SponsorBlock
            { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; }

            # RevEye Reverse Image Search
            { id = "keaaclcjhehbbapnphnmpiklalfhelgf"; }

            # Return YouTube Dislike
            { id = "gebbhagfogifgggkldgodflihgfeippi"; }

            # Old Reddit Redirect
            { id = "dneaehbmnbhcippjikoajpoabadpodje"; }

            # JSON Formatter
            { id = "bcjindcccaagfpapjjmafapmmgkkhgoa"; }

            # Desaturate Favicons
            { id = "dkenplobjcbiljmfbgpbpaboipfgpcbm"; }

            # Dark Reader
            { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; }

            # Better YouTube Shorts
            { id = "pehohlhkhbcfdneocgnfbnilppmfncdg"; }
        ];
    };
}
