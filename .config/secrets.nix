let
  bjUser = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN97AtDMw5iZKjShQOxV81eLCkHi8i9AOaQP0H3wwA9F amcmillan@beast-jr";
  bjSystem = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOYAOtQ5Wm/OHFyknj1gx/yXn4z9F5kARPT0jB554HXf root@beast-jr";
  lpUser = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFraBYWQ3Ly0DiQcXikoeMcwCkyOiUBYE/S668cjRFAk amcmillan@launchpad-9";
  lpSystem = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFf3pO79/frhAmL51gPmm5Y//mfUUWrMQCWr+Qs837sF root@launchpad-9";
  sbUser = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGIEcKo2I3Ku/bUjU9rl42UALJ9HoB5VSJHaYdSt8KBb amcmillan@super-beast-lx";
  sbSystem = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFwH6xxe5UcjTOvV7FiDNMmZsDTogdoC20A+OLjDQpeC root@super-beast-lx";

  allDevices = [
    bjUser bjSystem
    lpUser lpSystem
    sbUser sbSystem
  ];
in {
  "github-token.age".publicKeys = allDevices;
}
