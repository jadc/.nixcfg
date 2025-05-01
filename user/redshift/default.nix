# Redshift: Night shift
{
    services.redshift = {
        enable = true;
        dawnTime = "7:00-8:00";
        duskTime = "16:00-17:00";
    };
}
