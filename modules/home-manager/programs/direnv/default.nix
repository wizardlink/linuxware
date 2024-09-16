{ ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;

    config = {
      whitelist = {
        prefix = [
          "/mnt/internal/personal/projects"
          "/mnt/internal/repos"
          "/mnt/internal/shared/projects"
          "/mnt/internal/shared/work"
        ];
      };
    };
  };
}
