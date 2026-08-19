{ pkgs, ... }:

{
  services.scx = {
    enable = true;
    scheduler = "scx_bpfland";
  };

  environment.systemPackages = with pkgs; [
    scx-loader
  ];

  security.polkit.extraConfig = ''
    polkit.addRule(function (action, subject) {
      if (action.id.indexOf("org.scx.") === 0 && subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';
}
