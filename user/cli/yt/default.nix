{
    programs.yt-dlp = {
        enable = true;

        settings = {
            ignore-errors = true;
            no-continue = true;
            no-overwrites = true;
            add-metadata = true;
            #embed-thumbnail = true;
            #all-subs = true;
            #sub-format = "srt";
            #embed-subs  = true;
            output = "%(title)s.%(ext)s";

            # Download as MP4 if possible
            format-sort = "res,ext:mp4:m4a";
        };
    };
}
