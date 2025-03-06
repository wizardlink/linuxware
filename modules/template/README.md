# READ THIS BEFORE PROCEEDING

Below is a checklist of changes you need to do before rebuilding your system.

## Generate your system configuration and replace the placeholders.

You can achieve this by running `sudo nixos-generate-config`, then overwrite `hardware-configuration.nix` and
`configuration.nix` with the contents of the files found in `/etc/nixos`.

## Replace placeholder text

In `flake.nix` you will find `your-hostname-here`, replace with your machine's current hostname.

In `home-manager.nix` you have to replace:
- `your-username-here` with your user's username;
- `your-home-directory-here` with the path of your home directory, usually the same as your username;
- `your-hostname-here` with your machine's current hostname;
- `your-flake-location-here` with where you are storing the flake.
