return {
	"tomasr/molokai",
	lazy = false,
	priority = 1000,
	config = function()
		-- Molokai configuration
		vim.g.molokai_original = 0 -- Use the modified version (0) or original (1)
		vim.g.rehash256 = 1 -- Enable 256 color support

		-- Load the colorscheme
		vim.cmd([[colorscheme molokai]])

		-- Make background transparent by default (keeps vibrant colors, uses terminal background)
		vim.cmd([[
      hi Normal guibg=NONE ctermbg=NONE
      hi SignColumn guibg=NONE ctermbg=NONE
      hi NormalNC guibg=NONE ctermbg=NONE
      hi MsgArea guibg=NONE ctermbg=NONE
      hi TelescopeBorder guibg=NONE ctermbg=NONE
      hi NvimTreeNormal guibg=NONE ctermbg=NONE
      hi NeoTreeNormal guibg=NONE ctermbg=NONE
      hi NeoTreeNormalNC guibg=NONE ctermbg=NONE
    ]])

		-- Toggle between transparent and solid background
		local bg_transparent = true

		local toggle_transparency = function()
			bg_transparent = not bg_transparent
			if bg_transparent then
				vim.cmd([[
          hi Normal guibg=NONE ctermbg=NONE
          hi SignColumn guibg=NONE ctermbg=NONE
          hi NormalNC guibg=NONE ctermbg=NONE
          hi MsgArea guibg=NONE ctermbg=NONE
          hi TelescopeBorder guibg=NONE ctermbg=NONE
          hi NvimTreeNormal guibg=NONE ctermbg=NONE
          hi NeoTreeNormal guibg=NONE ctermbg=NONE
          hi NeoTreeNormalNC guibg=NONE ctermbg=NONE
        ]])
			else
				vim.cmd([[colorscheme molokai]])
			end
		end

		vim.keymap.set("n", "<leader>bg", toggle_transparency, { noremap = true, silent = true, desc = "Toggle background transparency" })
	end,
}
