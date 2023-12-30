{ pkgs, ... }:

let
  reshade-shaders = pkgs.callPackage ./shaders.nix {};
in 
{
  home.packages = with pkgs; [
    vkbasalt
  ];

  home.file = {
    ".config/vkBasalt/vkBasalt.conf".text = ''
      effects = cas:clarity:pcurved:pshadows:smaa:tonemap:vibrance

      reshadeTexturePath = ${reshade-shaders}/Textures
      reshadeIncludePath = ${reshade-shaders}/Shaders

      toggleKey = Home

      # FX
      cas = "${reshade-shaders}/Shaders/CAS.fx"
      clarity = "${reshade-shaders}/Shaders/Clarity.fx"
      pcurved = "${reshade-shaders}/Shaders/PD80_03_Curved_Levels.fx"
      pshadows = "${reshade-shaders}/Shaders/PD80_03_Shadows_Midtones_Highlights.fx"
      smaa = "${reshade-shaders}/Shaders/SMAA.fx"
      tonemap = "${reshade-shaders}/Shaders/Tonemap.fx"
      vibrance = "${reshade-shaders}/Shaders/Vibrance.fx"

      # Configure FX

      # Vibrance
      vibranceVibrance = 0.100000
      vibranceVibranceRGBBalance = 1.000000,1.000000,1.000000

      # Tonemap
      tonemapDefog = 0.100000
      tonemapBleach = 0.000000
      tonemapGamma = 1.000000
      tonemapExposure = 0.000000
      tonemapSaturation = -0.150000
      tonemapFogColor = 1.000000,1.000000,1.000000

      # CAS
      casSharpness = 0.40
    '';
  };
}
