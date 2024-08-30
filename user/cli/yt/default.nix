# YouTube downloader

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
            output = "%(title)s [%(upload_date)s %(id)s].%(ext)s";
        };
    };
}
