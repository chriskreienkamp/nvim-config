return {
	{
		"milanglacier/minuet-ai.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			-- Load centralized API configuration
			local api_config = require("config.api_config")
			local provider, provider_config = api_config.get_minuet_provider()

			-- Map our config to Minuet's expected format
			local provider_options = {}

			-- Configure all providers
			provider_options.openai = {
				model = api_config.openai.model,
				system = "You are a helpful coding assistant. You should provide accurate, concise code completions.",
				few_shots = {},
				stream = true,
				optional = {
					max_tokens = api_config.openai.max_tokens,
				},
			}

			provider_options.openai_compatible = {
				model = api_config.ollama.model,
				stream = true,
				end_point = api_config.ollama.endpoint,
				api_key = api_config.ollama.api_key,
				name = "Ollama",
				optional = {
					max_tokens = 256,
				},
			}

			provider_options.claude = {
				model = api_config.claude.model,
				system = "You are a helpful coding assistant.",
				few_shots = {},
				stream = true,
				optional = {
					max_tokens = api_config.claude.max_tokens,
				},
			}

			provider_options.codestral = {
				model = api_config.codestral.model,
				system = "You are a helpful coding assistant.",
				few_shots = {},
				stream = true,
				optional = {
					max_tokens = api_config.codestral.max_tokens,
					stop = nil,
				},
			}

			require("minuet").setup({
				-- Provider from centralized config
				provider = provider,

				-- Enable virtual text (inline ghost text suggestions)
				virtualtext = {
					auto_trigger = true,
					-- Enable for these file types (empty means all file types)
					auto_trigger_ft = { "python", "javascript", "typescript", "lua", "go", "rust", "java", "c", "cpp" },
					keymap = {
						accept = "<C-a>", -- Ctrl+a to accept whole completion
						accept_line = "<C-l>", -- Ctrl+l to accept one line
						next = "<M-]>", -- Alt+] for next suggestion
						prev = "<M-[>", -- Alt+[ for previous suggestion
						dismiss = "<C-e>", -- Ctrl+e to dismiss
					},
				},

				-- All provider options
				provider_options = provider_options,

				-- Request timeout in seconds
				request_timeout = 10,

				-- Context window configuration
				context = {
					-- Max lines before cursor
					max_num_lines_above = 100,
					-- Max lines after cursor
					max_num_lines_below = 20,
				},

				-- Debounce settings
				throttle = 1000, -- milliseconds

				-- Auto-completion settings
				auto_completion = true,

				-- Notification settings
				notify = "warn", -- Options: "warn", "error"
			})
		end,
	},
}
