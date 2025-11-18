return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		-- Only load if Copilot is enabled
		enabled = function()
			local api_config = require("config.api_config")
			return api_config.copilot.enabled
		end,
		opts = {
			debug = false, -- Enable debugging
			-- See Configuration section for rest of options
		},
		config = function(_, opts)
			local chat = require("CopilotChat")
			local select = require("CopilotChat.select")

			-- Setup CopilotChat
			chat.setup(opts)

			-- Keymaps
			vim.keymap.set({ "n", "v" }, "<leader>cc", function()
				chat.toggle()
			end, { desc = "CopilotChat - Toggle chat window" })

			vim.keymap.set({ "n", "v" }, "<leader>cq", function()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					chat.ask(input, { selection = select.buffer })
				end
			end, { desc = "CopilotChat - Quick chat" })

			-- Chat with selection
			vim.keymap.set("v", "<leader>cx", function()
				chat.ask("Explain the selected code", { selection = select.visual })
			end, { desc = "CopilotChat - Explain code" })

			vim.keymap.set("v", "<leader>ct", function()
				chat.ask("Write tests for the selected code", { selection = select.visual })
			end, { desc = "CopilotChat - Generate tests" })

			vim.keymap.set("v", "<leader>cf", function()
				chat.ask("Fix the selected code", { selection = select.visual })
			end, { desc = "CopilotChat - Fix code" })

			vim.keymap.set("v", "<leader>co", function()
				chat.ask("Optimize the selected code", { selection = select.visual })
			end, { desc = "CopilotChat - Optimize code" })

			vim.keymap.set("v", "<leader>cd", function()
				chat.ask("Add documentation for the selected code", { selection = select.visual })
			end, { desc = "CopilotChat - Document code" })

			-- Chat with entire buffer
			vim.keymap.set("n", "<leader>cb", function()
				local input = vim.fn.input("Ask about buffer: ")
				if input ~= "" then
					chat.ask(input, { selection = select.buffer })
				end
			end, { desc = "CopilotChat - Ask about buffer" })

			-- Custom prompts
			vim.keymap.set("n", "<leader>cp", function()
				local actions = require("CopilotChat.actions")
				require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
			end, { desc = "CopilotChat - Prompt actions" })

			-- Show help
			vim.keymap.set("n", "<leader>ch", function()
				local actions = require("CopilotChat.actions")
				require("CopilotChat.integrations.telescope").pick(actions.help_actions())
			end, { desc = "CopilotChat - Help actions" })

			-- Clear chat
			vim.keymap.set("n", "<leader>cr", function()
				chat.reset()
			end, { desc = "CopilotChat - Reset chat" })
		end,
	},
}
