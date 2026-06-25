{ pkgs, ... }:

{
  astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "astronaut";
    themeConfig = {
      Background = "${./wallpapers/astronaut}";

      Font = "Oswald";
      HourFormat = "HH:mm:ss";
      DateFormat = "dddd d MMMM";
    };
  };

  black_hole = pkgs.sddm-astronaut.override {
    embeddedTheme = "black_hole";
    themeConfig = {
      Background = "${./wallpapers/black_hole}";

      Font = "Orbitron";
      HourFormat = "HH:mm:ss";
      DateFormat = "dddd d MMMM";

      ScreenPadding = "0";
      HideLoginButton = "true";

      HeaderTextColor="#ffdfcf";
      DateTextColor="#ffdfcf";
      TimeTextColor="#ffdfcf";

      FormBackgroundColor="#22172a";
      BackgroundColor="#5c729d";
      DimBackgroundColor="#5c729d";

      LoginFieldBackgroundColor="#352442";
      PasswordFieldBackgroundColor="#352442";
      LoginFieldTextColor="#ffdfcf";
      PasswordFieldTextColor="#ffdfcf";
      UserIconColor="#ffdfcf";
      PasswordIconColor="#ffdfcf";

      PlaceholderTextColor="#cebddb";
      WarningColor="#ffdfcf";

      SystemButtonsIconsColor="#ffdfcf";
      SessionButtonTextColor="#ffdfcf";
      VirtualKeyboardButtonTextColor="#ffdfcf";

      DropdownTextColor="#ffdfcf";
      DropdownSelectedBackgroundColor="#402b4f";
      DropdownBackgroundColor="#352442";

      HighlightTextColor="#1e1f2f";
      HighlightBackgroundColor="#352442";
      HighlightBorderColor="#402b4f";

      HoverUserIconColor="#fff1eb";
      HoverPasswordIconColor="#fff1eb";
      HoverSystemButtonsIconsColor="#fff1eb";
      HoverSessionButtonTextColor="#fff1eb";
      HoverVirtualKeyboardButtonTextColor="#fff1eb";
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
