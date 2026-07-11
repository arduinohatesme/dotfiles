{ pkgs, ... }:

{
  astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "astronaut";
    themeConfig = {
      Background = "${./wallpapers/astronaut}";

      Font = "Oswald";
      HourFormat = "HH:mm:ss";
      DateFormat = "dddd d MMMM";

      HideLoginButton = "true";
      HaveFormBackground = "false";
      Blur = "0.0";
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

      HeaderTextColor = "#ffdfcf";
      DateTextColor = "#ffdfcf";
      TimeTextColor = "#ffdfcf";

      FormBackgroundColor = "#22172a";
      BackgroundColor = "#5c729d";
      DimBackgroundColor = "#5c729d";

      LoginFieldBackgroundColor = "#352442";
      PasswordFieldBackgroundColor = "#352442";
      LoginFieldTextColor = "#ffdfcf";
      PasswordFieldTextColor = "#ffdfcf";
      UserIconColor = "#ffdfcf";
      PasswordIconColor = "#ffdfcf";

      PlaceholderTextColor = "#cebddb";
      WarningColor = "#ffdfcf";

      SystemButtonsIconsColor = "#ffdfcf";
      SessionButtonTextColor = "#ffdfcf";
      VirtualKeyboardButtonTextColor = "#ffdfcf";

      DropdownTextColor = "#ffdfcf";
      DropdownSelectedBackgroundColor = "#402b4f";
      DropdownBackgroundColor = "#352442";

      HighlightTextColor = "#1e1f2f";
      HighlightBackgroundColor = "#352442";
      HighlightBorderColor = "#402b4f";

      HoverUserIconColor = "#fff1eb";
      HoverPasswordIconColor = "#fff1eb";
      HoverSystemButtonsIconsColor = "#fff1eb";
      HoverSessionButtonTextColor = "#fff1eb";
      HoverVirtualKeyboardButtonTextColor = "#fff1eb";
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
      Blur = "0.0";
      HideLoginButton = "true";

      HeaderTextColor = "#f5faff";
      DateTextColor = "#f5faff";
      TimeTextColor = "#f5faff";

      FormBackgroundColor = "#21222c";
      BackgroundColor = "#21222c";
      DimBackgroundColor = "#21222c";

      LoginFieldBackgroundColor = "#21222c";
      PasswordFieldBackgroundColor = "#21222c";
      LoginFieldTextColor = "#f5faff";
      PasswordFieldTextColor = "#f5faff";
      UserIconColor = "#f5faff";
      PasswordIconColor = "#f5faff";

      PlaceholderTextColor = "#c7cdd1";
      WarningColor = "#403438";

      SystemButtonsIconsColor = "#f5faff";
      SessionButtonTextColor = "#f5faff";
      VirtualKeyboardButtonTextColor = "#f5faff";

      DropdownTextColor = "#f5faff";
      DropdownSelectedBackgroundColor = "#373737";
      DropdownBackgroundColor = "#272727";

      HighlightTextColor = "#f5faff";
      HighlightBackgroundColor = "#89959f";
      HighlightBorderColor = "#89959f";

      HoverUserIconColor = "#ffffff";
      HoverPasswordIconColor = "#ffffff";
      HoverSystemButtonsIconsColor = "#ffffff";
      HoverSessionButtonTextColor = "#ffffff";
      HoverVirtualKeyboardButtonTextColor = "#ffffff";
    };
  };

  sakura = pkgs.sddm-astronaut.override {
    embeddedTheme = "pixel_sakura";
    themeConfig = {
      Background = "${./wallpapers/sakura_anim}";
      Font = "Unifont";

      RoundCorners = "0";
      HourFormat = "HH:mm:ss";
      DateFormat = "dddd d MMMM";
    };
  };
}
