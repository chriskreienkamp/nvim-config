return {
	{
		"zbirenbaum/copilot.lua",
		-- Load enabled status from centralized config
		enabled = function()
			local api_config = require("config.api_config")
			return api_config.copilot.enabled
		end,
		lazy = false,
		config = function()
			-- Load centralized API configuration
			local api_config = require("config.api_config")

			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = api_config.copilot.auto_trigger,
					keymap = {
						accept = "<C-l>", -- Accept suggestion
						next = "<M-]>", -- Next suggestion
						prev = "<M-[>", -- Previous suggestion
						dismiss = "<C-]>",
					},
				},
				panel = { enabled = true },
			})
		end,
	},
}
