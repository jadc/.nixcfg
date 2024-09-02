{
    services.nfs.server = {
        enable = true;
        exports = "/data *(rw,insecure,fsid=0,no_subtree_check)";
    };
}
