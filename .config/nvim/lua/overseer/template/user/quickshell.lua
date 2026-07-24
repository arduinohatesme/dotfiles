return {
  name = "Restart quickshell",
  condition = {
    dir = "/home/amcmillan/.config/quickshell/",
  },
  builder = function()
    return {
      cmd = { "sh", "-c", "pkill quickshell; qs" },
    }
  end,
}
