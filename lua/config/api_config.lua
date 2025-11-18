-- Centralized API Configuration
-- ====================================
-- All API keys, endpoints, and sensitive configuration in one place
-- Copy this file to get started, then add your actual API keys below

local M = {}

-- ============================================================================
-- AI PROVIDER SETTINGS
-- ============================================================================

-- Which AI provider to use for Minuet completions
-- Options: "local_ollama", "openai", "claude", "codestral"
M.minuet_provider = "local_ollama"

-- ============================================================================
-- LOCAL OLLAMA CONFIGURATION (No API key needed - runs locally)
-- ============================================================================
M.ollama = {
	endpoint = "http://localhost:11434/v1/chat/completions",
	model = "qwen2.5-coder:3b", -- Change to your preferred local model
	-- For Ollama, api_key can be any environment variable that exists
	api_key = "TERM", -- Dummy value, Ollama doesn't need real API key
}

-- ============================================================================
-- LOCAL LLM CLI CONFIGURATION (For ChatGPT plugin using 'llm' command)
-- ============================================================================
M.local_llm = {
	-- Model to use with the 'llm' CLI tool
	model = "qwen2.5-coder:3b", -- Change to your preferred local model
}

-- ============================================================================
-- OPENAI CONFIGURATION
-- ============================================================================
M.openai = {
	-- Get your API key from: https://platform.openai.com/api-keys
	api_key = os.getenv("OPENAI_API_KEY") or "", -- Set OPENAI_API_KEY environment variable
	model = "gpt-4o-mini", -- Options: gpt-4o, gpt-4o-mini, gpt-3.5-turbo
	max_tokens = 256,
}

-- ============================================================================
-- ANTHROPIC CLAUDE CONFIGURATION
-- ============================================================================
M.claude = {
	-- Get your API key from: https://console.anthropic.com/
	api_key = os.getenv("ANTHROPIC_API_KEY") or "", -- Set ANTHROPIC_API_KEY environment variable
	model = "claude-3-5-sonnet-20241022", -- Options: claude-3-5-sonnet-20241022, claude-3-opus-20240229
	max_tokens = 256,
}

-- ============================================================================
-- CODESTRAL CONFIGURATION (Mistral AI)
-- ============================================================================
M.codestral = {
	-- Get your API key from: https://console.mistral.ai/
	api_key = os.getenv("CODESTRAL_API_KEY") or "", -- Set CODESTRAL_API_KEY environment variable
	model = "codestral-latest",
	max_tokens = 256,
}

-- ============================================================================
-- GITHUB COPILOT CONFIGURATION
-- ============================================================================
M.copilot = {
	-- Enable or disable Copilot globally
	-- NOTE: Copilot requires GitHub authentication via :Copilot auth
	-- WARNING: Only enable if approved for use with company/sensitive code
	enabled = false,

	-- Auto-trigger suggestions
	auto_trigger = true,
}

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================

-- Get the active provider configuration for Minuet
function M.get_minuet_provider()
	if M.minuet_provider == "local_ollama" then
		return "openai_compatible", M.ollama
	elseif M.minuet_provider == "openai" then
		return "openai", M.openai
	elseif M.minuet_provider == "claude" then
		return "claude", M.claude
	elseif M.minuet_provider == "codestral" then
		return "codestral", M.codestral
	else
		error("Unknown provider: " .. M.minuet_provider)
	end
end

return M
