return {
	{
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			-- Load centralized API configuration
			local api_config = require("config.api_config")
			local llm_model = api_config.local_llm.model

			-- Function to call LLM and show result
			local function send_to_llm(prompt)
				local command = string.format("llm -m %s %q", llm_model, prompt)
				vim.fn.jobstart(command, {
					stdout_buffered = true,
					on_stdout = function(_, data)
						if data then
							vim.schedule(function()
								vim.notify(table.concat(data, "\n"), vim.log.levels.INFO)
							end)
						end
					end,
					on_stderr = function(_, err)
						if err then
							vim.schedule(function()
								vim.notify("LLM error: " .. table.concat(err, "\n"), vim.log.levels.ERROR)
							end)
						end
					end,
				})
			end

			-- Visual mode: send selection to LLM
			vim.keymap.set("v", "<leader>ll", function()
				local start_pos = vim.fn.getpos("'<")[2]
				local end_pos = vim.fn.getpos("'>")[2]
				local lines = vim.fn.getline(start_pos, end_pos)
				local prompt = table.concat(lines, " ")
				send_to_llm(prompt)
			end, { noremap = true, silent = true, desc = "Send selection to LLM" })

			-- Normal mode: prompt for user input
			vim.keymap.set("n", "<leader>lp", function()
				vim.ui.input({ prompt = "Prompt for " .. llm_model .. " > " }, function(input)
					if input then
						send_to_llm(input)
					end
				end)
			end, { noremap = true, silent = true, desc = "Prompt LLM" })
		end,
	},
}
