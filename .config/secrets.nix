let
  bjUser = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN97AtDMw5iZKjShQOxV81eLCkHi8i9AOaQP0H3wwA9F amcmillan@beast-jr";
  bjSystem = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOYAOtQ5Wm/OHFyknj1gx/yXn4z9F5kARPT0jB554HXf root@beast-jr";
  lpUser = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFraBYWQ3Ly0DiQcXikoeMcwCkyOiUBYE/S668cjRFAk amcmillan@launchpad-9";
  lpSystem = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFf3pO79/frhAmL51gPmm5Y//mfUUWrMQCWr+Qs837sF root@launchpad-9";

  allDevices = [
    bjUser bjSystem
    lpUser lpSystem
  ];
in {
  "github-token.age".publicKeys = allDevices;
}
