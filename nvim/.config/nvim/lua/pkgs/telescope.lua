local loaded, telescope = pcall(require, "nvim-telescope/telescope.nvim")
if not loaded then
  return
end

telescope.setup({
  extensions = {
    file_browser = {
      theme = "ivy",
    }
  },
})
