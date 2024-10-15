# Redshift: Night shift
{
    services.redshift = {
        enable = true;
        dawnTime = "8:00-9:00";
        duskTime = "19:00-20:00";
    };
}
