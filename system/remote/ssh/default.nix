# Enables SSH server (sshd)

{
    services.openssh.enable = true;
    services.openssh.settings.X11Forwarding = true;
}
