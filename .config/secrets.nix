let
  bjUser = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN97AtDMw5iZKjShQOxV81eLCkHi8i9AOaQP0H3wwA9F amcmillan@beast-jr";
  bjSystem = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOYAOtQ5Wm/OHFyknj1gx/yXn4z9F5kARPT0jB554HXf root@beast-jr";

  allDevices = [
    bjUser bjSystem
  ];
in {
  "github-token.age".publicKeys = allDevices;
}
