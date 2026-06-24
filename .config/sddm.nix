{ pkgs, ... }:

{
  astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "astronaut";
    themeConfig = {
      Background = "${./wallpapers/astronaut}";

      HourFormat = "HH:mm:ss";
      DateFormat = "dddd d MMMM";
    };
  };

  black_hole = pkgs.sddm-astronaut.override {
    embeddedTheme = "black_hole";
    themeConfig = {
      Background = "${./wallpapers/black_hole}";

      Font = "Space Grotesk";
      HourFormat = "HH:mm:ss";
      DateFormat = "dddd d MMMM";

      ScreenPadding = "0";
    };
  };

  mountain = pkgs.sddm-astronaut.override {
    embeddedTheme = "astronaut";
    themeConfig = {
      Background = "${./wallpapers/mountain}";

      Font = "JetBrainsMono Nerd Font";
      RoundCorners = "0";
      HourFormat = "HH:mm:ss";
      DateFormat = "dddd d MMMM";

      FormPosition = "center";
      ScreenPadding = "0";
      Blur="1.0";

      HeaderTextColor = "#afaaaf";
      DateTextColor="#afaaaf";
      TimeTextColor="#afaaaf";

      FormBackgroundColor="#21222C";
      BackgroundColor="#21222C";
      DimBackgroundColor="#21222C";

      LoginFieldBackgroundColor="#222222";
      PasswordFieldBackgroundColor="#222222";
      LoginFieldTextColor="#ffffff";
      PasswordFieldTextColor="#ffffff";
      UserIconColor="#dfdddf";
      PasswordIconColor="#dfdddf";

      PlaceholderTextColor="#bbbbbb";
      WarningColor="#403438";

      LoginButtonTextColor="#ffffff";
      LoginButtonBackgroundColor="#403438";
      SystemButtonsIconsColor="#dfdddf";
      SessionButtonTextColor="#dfdddf";
      VirtualKeyboardButtonTextColor="#dfdddf";

      DropdownTextColor="#dfdddf";
      DropdownSelectedBackgroundColor="#403438";
      DropdownBackgroundColor="#2C2221";

      HighlightTextColor="#bbbbbb";
      HighlightBackgroundColor="#403438";
      HighlightBorderColor="#403438";

      HoverUserIconColor="#cecece";
      HoverPasswordIconColor="#cecece";
      HoverSystemButtonsIconsColor="#cecece";
      HoverSessionButtonTextColor="#cecece";
      HoverVirtualKeyboardButtonTextColor="#cecece";
    };
  };

  sakura = pkgs.sddm-astronaut.override {
    embeddedTheme = "pixel_sakura";
    themeConfig = {
      Background = "${./wallpapers/sakura_anim}";
      Font="Unifont";

      RoundCorners = "0";
      HourFormat = "HH:mm:ss";
      DateFormat = "dddd d MMMM";
    };
  };
}
