{ config, pkgs, ... }:

{
    imports =
        [
            ./hardware-configuration.nix
        ];

    config = {
        # Bootloader
        boot.loader.grub.enable = true;
        boot.loader.grub.device = "/dev/vda";
        boot.loader.grub.useOSProber = true;

        # Hostname
        networking.hostName = "jadc";

        # Enable networking
        networking.networkmanager.enable = true;

        # Time zone
        time.timeZone = "America/Edmonton";

        # Locale
        i18n.defaultLocale = "en_CA.UTF-8";

        # Keymap in X11
        services.xserver.xkb = {
            layout = "us";
            variant = "";
        };

        # Create user
        users.users.jad = {
            isNormalUser = true;
            description = "jad";
            extraGroups = [ "networkmanager" "wheel" ];
            packages = with pkgs; [];
        };

        # Enable automatic login for the user.
        services.getty.autologinUser = "jad";

        # Set default shell to zsh for all users
        environment.shells = with pkgs; [ zsh ];
        users.defaultUserShell = pkgs.zsh;
        programs.zsh.enable = true;

        # List packages installed in system profile. To search, run:
        # $ nix search wget
        environment.systemPackages = with pkgs; [
            vim
            wget
            git
        ];

        # Some programs need SUID wrappers, can be configured further or are
        # started in user sessions.
        # programs.mtr.enable = true;
        # programs.gnupg.agent = {
        #     enable = true;
        #     enableSSHSupport = true;
        # };

        # List services that you want to enable:

        # Enable the OpenSSH daemon.
        # services.openssh.enable = true;

        # Open ports in the firewall.
        # networking.firewall.allowedTCPPorts = [ ... ];
        # networking.firewall.allowedUDPPorts = [ ... ];
        # Or disable the firewall altogether.
        # networking.firewall.enable = false;

        # Enable flakes
        nix.settings.experimental-features = [ "nix-command" "flakes" ];

        # Clean >= 30 day old generations every week
        nix.gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 30d";
        };

        # Do not need to update
        system.stateVersion = "24.05";
    };
}
