return {
	astronaut = {
		general = {
			border_size = 0,
			gaps_in = 5,
			gaps_out = { top = 44, left = 22, right = 22, bottom = 22 },

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
			gaps_out = { top = 44, left = 22, right = 22, bottom = 22 },

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
			rounding = 15,
			rounding_power = 5,
			dim_inactive = true,
			dim_strength = 0.25,

			-- Change transparency of focused and unfocused windows
			active_opacity = 0.7,
			inactive_opacity = 0.7,

			shadow = {
				enabled = false,
				range = 30,
				render_power = 3,
				color = 0xee1a1a1a,
			},

			blur = {
				enabled = true,
				size = 13,
				passes = 3,
				vibrancy = 0.2,
			},
		},
	},

	mountain = {
		general = {
			border_size = 3,
			gaps_in = 5,
			gaps_out = { top = 44, left = 22, right = 22, bottom = 22 },

			col = {
				active_border = { colors = { "rgba(bbccddee)", "rgba(bbddbbee)" }, angle = 45 },
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
			dim_strength = 0.25,

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
				enabled = false,
				size = 10,
				passes = 3,
				vibrancy = 0.1696,
			},
		},
	},

	sakura = {
		general = {
			border_size = 3,
			gaps_in = 5,
			gaps_out = { top = 44, left = 22, right = 22, bottom = 22 },

			col = {
				active_border = { colors = { "rgba(f8ac9eee)", "rgba(ddaaddee)" }, angle = 45 },
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
