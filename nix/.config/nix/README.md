Test nix is installed correctly:
```
nix-shell -p nix-info --run "nix-info -m"
```

First run:

```
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.config/nix
```

Then after config change:
```
darwin-rebuild switch --flake ~/.config/nix
```
