{ config, lib, pkgs, ... }:

with lib;

{
  config = {
    programs.rofi = {
      enable = true;

      theme = with config.lib.formats.rasi; {
        "*" = {
          background-color = mkLiteral "#000000";
          foreground-color = mkLiteral "rgba ( 250, 251, 252, 100 % )";
          border-color = mkLiteral "#FFFFFF";
          width = 512;
        };

        "#textbox-prompt-colon" = {
          expand = false;
          str = ":";
          margin = mkLiteral "0px 0.3em 0em 0em";
          text-color = mkLiteral "@foreground-color";
        };
      };
    };

    nixpkgs.overlays =
      [ (self: super: { rofi = pkgs.writeScriptBin "dummy-rofi" ""; }) ];

    nmt.script = ''
      assertFileContent \
        home-files/.config/rofi/config.rasi \
        ${./custom-theme-config.rasi}
      assertFileContent \
        home-files/.local/share/rofi/themes/custom.rasi \
        ${./custom-theme.rasi}
    '';
  };
}
