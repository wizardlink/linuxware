{ pkgs, yazi, ... }:

{
  programs.yazi = {
    enable = true;
    package = yazi.packages.${pkgs.system}.default;

    settings = {
      opener = {
        text = [{
          block = true;
          exec = "nvim \"$@\"";
        }];
      };

      theme = builtins.readFile ./theme.toml;
    };
  };
}
