-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor {
	output = "DP-2",
	mode = "2560x1440@165.00301",
	position = "auto",
	scale = "auto",
}

hl.monitor {
	output = "DP-3",
	mode = "1920x1080@74.973",
	position = "auto",
	scale = "auto",
}

hl.config {
	input = {
		tablet = {
			output = "DP-2",
		},
	},
}
