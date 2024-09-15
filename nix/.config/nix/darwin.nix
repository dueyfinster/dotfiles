{ pkgs, lib, inputs, config, username, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
        # common Darwin packages
        bat
        eza
        neovim
      ] ++ (if system == "aarch64-darwin" then [
        # ARM-only packages

      ] else [
        # Intel-only packages
        # Darwin packages for Intel-only
        gdb
        ghidra-bin
      ]);

       homebrew = {
        enable = true;
        global = {
          autoUpdate = false;
        };
        onActivation = {
          autoUpdate = false;
          # cleanup = "uninstall";
          extraFlags = [
            "--verbose"
          ];
        };
        brews = [
          "pidof"
          "pcalc"
        ];
        casks = [
          "anki"
          #"crossover"
          "iterm2"
          "kitty"
          "drawio"
          "docker"
          "firefox@developer-edition"
          "sonos"
          "spotify"
          "wezterm"
        ];
        masApps = {
          "Reeder" = 1529448980;
          "Things" = 904280696;
        };
      };


      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      # programs.zsh.enable = true;  # default shell on catalina
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      users.users.egronei = {
        name = "egronei";
        home = "/Users/egronei";
    };
}
