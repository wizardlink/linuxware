The [NixOS] module installs [Hyprland] onto the system.

Whilst the [Home Manager] module generates the dotfiles for [Hyprland] and optionally [hypridle].

It can be configured through `modules.hyprland`.

## Module options

### extraConfig

`modules.hyprland.extraConfig` when set will be appended to the top of the configuration I generate, you can see where
that is [here](./home-manager.nix#L189).

There are no monitors configured by default, so you should use this option to do so.

### hypridle.enable

Whether to configure and enable the [hypridle] package. Be mindful that it may not auto-start, I have yet to find why but
even though it configures to start after `graphical-session.target`, that isn't reached in Hyprland sometimes.

### scripts.screenshot.enable

When enabled it will create two script files in `$XDG_DATA_HOME/scripts/hyprland` and two keybinds for you to run these
scripts, allowing you to take screenshots of a region and the entire screen of your first monitor.

### scripts.startup.enable

Not my proudest option, this will add two packages containing a startup script for apps that I use in the daily &
services. If this module ever gets actually used by someone, then I'll refine it.

## Visuals

### Active window

![image](/assets/screenshots/hyprland-active.png)

### Inactive window

![image](/assets/screenshots/hyprland-inactive.png)

### Gaps

![image](/assets/screenshots/hyprland-gaps.png)


<!-- REFERENCES -->
[hyprland]: https://hyprland.org/
[hypridle]: https://github.com/hyprwm/hypridle
[home manager]: https://github.com/nix-community/home-manager
[nixos]: https://nixos.org
