return {
	{ "norcalli/nvim-colorizer.lua",
  name = "nvim-colorizer", 
  priority = 1000,
  config = function()
    vim.opt.termguicolors = true
    require("colorizer").setup()
  end
  },
}
