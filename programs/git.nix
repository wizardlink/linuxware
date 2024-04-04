{ ... }:

{
  # Enable GIT.
  programs.git = {
    enable = true;

    aliases = {
      # List aliases
      aliases = "config --get-regexp alias";

      # List all the contributors with commit amount
      contributors = "shortlog --summary --numbered";

      # Output verbose info about branches and tags
      branches = "branch -avv";

      # List all tags
      tags = "tag -l";

      # Pretty logs
      plog = "log --graph --decorate --all";

      # Pretty grep
      gcommit = "log --graph --decorate --grep";
    };

    extraConfig = {
      core = {
        # Set the editor to be used by GIT
        editor = "nvim";

        # Custom .gitignore
        excludesfile = "~/.gitignore";

        # Treat trailing whitespaces and spaces before tabs as an error
        whitespace = "space-before-tab,-indent-with-non-tab,trailing-space";
      };

      color = {
        # Use colors in GIT commmands.
        ui = "auto";
      };

      commit = {
        # https://help.github.com/articles/signing-commits-using-gpg/
        gpgsign = true;
      };

      tag = { gpgsign = true; };

      difftool = { prompt = true; };

      mergetool = {
        # https://www.git-scm.com/docs/git-mergetool#Documentation/git-mergetool.txt---no-prompt
        prompt = false;
      };

      merge = {
        # https://git-scm.com/docs/git-merge#_how_conflicts_are_presented
        conflictstyle = "diff3";
      };

      push = {
        # https://stackoverflow.com/questions/21839651/git-what-is-the-difference-between-push-default-matching-and-simple
        default = "simple";

        # git-push pushes relevant annotated tags when pushing branches out
        followTags = true;
      };

      user = {
        name = "Alexandre Cavalheiro S. Tiago da Silva";
        email = "contact@thewizard.link";
        signingkey = "A1D3A2B4E14BD7C0445BB749A5767B54367CFBDF";
      };

      pull = { ff = "only"; };

      init = { defaultBranch = "main"; };

      credential = {
        helper = "/usr/libexec/git-core/git-credential-libsecret";
      };
    };
  };
}
