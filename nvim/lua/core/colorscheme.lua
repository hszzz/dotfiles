vim.o.background = "dark"

local colorscheme = "oxocarbon"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme: " .. colorscheme .. " NOT found!")
  return
end

return colorscheme
