local status, tokyonight = pcall(require, "tokyonight")
if not status then
    return
end

tokyonight.setup({
    style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    light_style = "day", -- The theme is used when the background is set to light
    transparent = false, -- Enable this to disable setting the background color
})

-- setup must be called before loading
vim.cmd("colorscheme tokyonight")