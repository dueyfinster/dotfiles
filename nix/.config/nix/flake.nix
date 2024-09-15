{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, ... }:
    let
      machines = [
        { name = "EMB-2P2T1PXX"; system = "aarch64-darwin"; username = "egronei"; }
        { name = "Neils-iMac-Pro"; system = "x86_64-darwin"; username = "ngrogan"; }
      ];

      darwinConfigurationFor = machine: nix-darwin.lib.darwinSystem {
        inherit (machine) system;

        # See https://github.com/LnL7/nix-darwin#using-flake-inputs
        specialArgs = {
          inherit inputs;
          # TODO: Refactor to DRY-up shared specialArgs use across configs
          inherit (machine) username;
        };

        modules = [
          ./darwin.nix
          # https://nix-community.github.io/home-manager/nix-darwin-options.html
          home-manager.darwinModules.home-manager
          {
            home-manager.backupFileExtension = "backup";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${machine.username} = import ./home.nix;
            home-manager.verbose = true;
          }
        ];
      };
    in
    {
      darwinConfigurations =
        builtins.listToAttrs (map
          (machine: {
            inherit (machine) name;
            value = darwinConfigurationFor machine;
          })
          machines);

      # TODO: Bring Linux configuration into scope
      # See https://github.com/vidbina/nixos-configuration
      # nixosConfigurations.""
    };
}
