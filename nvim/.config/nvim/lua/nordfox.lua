local palettes = {
	-- Change nordfox to match the nordic Alacritty theme
	nordfox = {
		black = {
			base = "#191C1D", -- Normal black
			bright = "#727C7C", -- Bright black
			dim = "#242933", -- Dim black (background color)
		},
		red = {
			base = "#BD6062", -- Normal red
			bright = "#D18FAF", -- Bright red
			dim = "#762121", -- Dim red (darker variant)
		},
		green = {
			base = "#A3D6A9", -- Normal green
			bright = "#B7CEB0", -- Bright green
			dim = "#5E8C61", -- Dim green (darker variant)
		},
		yellow = {
			base = "#F0DFAF", -- Normal yellow
			bright = "#FFF6BF", -- Bright yellow (lighter version of base)
			dim = "#A8975E", -- Dim yellow (darker variant)
		},
		blue = {
			base = "#8FB4D8", -- Normal blue
			bright = "#C5D8F5", -- Bright blue (lighter version of base)
			dim = "#5E81AC", -- Dim blue (darker variant)
		},
		magenta = {
			base = "#C7A9D9", -- Normal magenta
			bright = "#E2D2F1", -- Bright magenta (lighter version of base)
			dim = "#9168A6", -- Dim magenta (darker variant)
		},
		cyan = {
			base = "#87C0CD", -- Normal cyan
			bright = "#C3E6ED", -- Bright cyan (lighter version of base)
			dim = "#47818E", -- Dim cyan (darker variant)
		},
		white = {
			base = "#BDC5BD", -- Normal white
			bright = "#F6F6F6", -- Bright white (lighter version of base)
			dim = "#7C7C7C", -- Dim white (darker variant)
		},
		bg0 = "#1C1F21", -- Darker variant of base background color
		bg1 = "#242933", -- Base background color
		bg2 = "#2B303B", -- Incrementally lighter background color
		bg3 = "#353B45", -- Incrementally lighter background color
		bg4 = "#3E4451", -- Incrementally lighter background color

		fg0 = "#AAAAAA", -- Darker variant of base foreground color
		fg1 = "#BBBDAF", -- Base foreground color
		fg2 = "#CBCED0", -- Incrementally lighter foreground color
		fg3 = "#D7DADC", -- Incrementally lighter foreground color
		fg4 = "#E2E5E9", -- Incrementally lighter foreground color

		sel0 = "#353B45", -- Selection color (slightly lighter)
		sel1 = "#2B303B", -- Selection color (slightly lighter)
		comment = "#8A8FAD",
	},
}

return palettes
