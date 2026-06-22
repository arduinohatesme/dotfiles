return {
  astronaut = {
    general = {
      gaps_in = 5,
      gaps_out = 22,

      border_size = 0,

      col = {
        active_border = { colors = { "rgba(6e93ccee)", "rgba(78c9d8ee)" }, angle = 45 },
        inactive_border = "rgba(262c3caa)",
      },
      -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
      resize_on_border = false,

      -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
      allow_tearing = false,

      layout = "dwindle",
    },

    decoration = {
      rounding = 10,
      rounding_power = 2,
      dim_inactive = true,
      dim_strength = 0.15,

      -- Change transparency of focused and unfocused windows
      active_opacity = 0.8,
      inactive_opacity = 0.8,

      shadow = {
        enabled = false,
        range = 30,
        render_power = 3,
        color = 0xee1a1a1a,
      },

      blur = {
        enabled = true,
        size = 2,
        passes = 3,
        vibrancy = 0.1696,
      },
    },
  },

	black_hole = {
    general = {
      gaps_in = 5,
      gaps_out = 22,

      border_size = 0,

      col = {
        active_border = { colors = { "rgba(6e93ccee)", "rgba(78c9d8ee)" }, angle = 45 },
        inactive_border = "rgba(262c3caa)",
      },
      -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
      resize_on_border = false,

      -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
      allow_tearing = false,

      layout = "dwindle",
    },

    decoration = {
      rounding = 10,
      rounding_power = 2,
      dim_inactive = true,
      dim_strength = 0.15,

      -- Change transparency of focused and unfocused windows
      active_opacity = 0.8,
      inactive_opacity = 0.8,

      shadow = {
        enabled = false,
        range = 30,
        render_power = 3,
        color = 0xee1a1a1a,
      },

      blur = {
        enabled = true,
        size = 2,
        passes = 3,
        vibrancy = 0.1696,
      },
    },
	},

  mountain = {
    general = {
      gaps_in = 5,
      gaps_out = 22,

      border_size = 2,

      col = {
        active_border = { colors = { "rgba(9999aaee)", "rgba(aa99aaee)" }, angle = 45 },
        inactive_border = "rgba(262c3caa)",
      },
      -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
      resize_on_border = false,

      -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
      allow_tearing = false,

      layout = "dwindle",
    },

    decoration = {
      dim_inactive = true,
      dim_strength = 0.15,

      -- Change transparency of focused and unfocused windows
      active_opacity = 0.85,
      inactive_opacity = 0.8,

      shadow = {
        enabled = false,
        range = 30,
        render_power = 3,
        color = 0xee1a1a1a,
      },

      blur = {
        enabled = false,
        size = 2,
        passes = 2,
        vibrancy = 0.1696,
      },
    },
  },

  sakura = {
    general = {
      gaps_in = 5,
      gaps_out = 22,

      border_size = 3,

      col = {
        active_border = { colors = { "rgba(ddddddee)", "rgba(ddaaddee)" }, angle = 45 },
        inactive_border = "rgba(262c3caa)",
      },
      -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
      resize_on_border = false,

      -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
      allow_tearing = false,

      layout = "dwindle",
    },

    decoration = {
      dim_inactive = true,
      dim_strength = 0.15,

      -- Change transparency of focused and unfocused windows
      active_opacity = 0.85,
      inactive_opacity = 0.8,

      shadow = {
        enabled = false,
        range = 30,
        render_power = 3,
        color = 0xee1a1a1a,
      },

      blur = {
        enabled = false,
        size = 2,
        passes = 2,
        vibrancy = 0.1696,
      },
    },
  },
}
