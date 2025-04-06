{ pkgs, ... }:

{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      input-overlay
      obs-backgroundremoval
      obs-gstreamer
      obs-pipewire-audio-capture
      obs-vkcapture
    ];
  };

  home.packages = [
    pkgs.obs-studio-plugins.obs-vkcapture
  ];
}
