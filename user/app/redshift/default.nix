# Redshift: Night shift
{
    services.redshift = {
        enable = true;
        dawnTime = "8:00-9:00";
        duskTime = "21:00-22:00";
    };
}
