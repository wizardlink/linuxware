{ ... }:

{
  programs.wezterm = {
    enable = true;
    extraConfig = # lua
      ''
        local wezterm = require("wezterm")

        -- Needed for folke's ZenMode in neovim
        wezterm.on('user-var-changed', function(window, pane, name, value)
            local overrides = window:get_config_overrides() or {}
            if name == "ZEN_MODE" then
                local incremental = value:find("+")
                local number_value = tonumber(value)
                if incremental ~= nil then
                    while (number_value > 0) do
                        window:perform_action(wezterm.action.IncreaseFontSize, pane)
                        number_value = number_value - 1
                    end
                    overrides.enable_tab_bar = false
                elseif number_value < 0 then
                    window:perform_action(wezterm.action.ResetFontSize, pane)
                    overrides.font_size = nil
                    overrides.enable_tab_bar = true
                else
                    overrides.font_size = number_value
                    overrides.enable_tab_bar = false
                end
            end
            window:set_config_overrides(overrides)
        end)

        return {
        	color_scheme = "Catppuccin Frappe",
        	enable_wayland = false, -- Unfortunately broken on Hyprland, AGAIN
        	font = wezterm.font("FantasqueSansM Nerd Font"),
        	font_size = 13,
        	hide_tab_bar_if_only_one_tab = true,
        	hide_mouse_cursor_when_typing = false,
        	window_background_opacity = 0.88,
        	window_padding = {
        		left = 18,
        		right = 18,
        		top = 18,
        		bottom = 18,
        	},
        }
      '';
  };
}
