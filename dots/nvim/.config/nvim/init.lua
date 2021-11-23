require('plugins')
require('mappings')
require('options')
require('packer_compiled')

local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

vim.api.nvim_command[[autocmd BufWritePost plugins.lua PackerCompile]]

vim.cmd [[
    augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup='IncSearch', timeout=700}
    augroup END
]]

-- remove trailing whitespace on save
vim.cmd [[
    augroup remove_whitespace
    autocmd!
    autocmd BufWrite * mark ' | silent! %s/\s\+$// | norm ''
    augroup END
]]

-- skeleton templates
vim.cmd [[
    augroup skeleton
    autocmd!
    autocmd BufNewFile *.sh 0r ~/bin/templates/skeleton.sh
    augroup END
]]

-- local options
vim.cmd [[augroup vimrc]]
    vim.cmd [[autocmd!]]
    -- vim.cmd [[autocmd FileType markdown setlocal spell]]
    vim.cmd [[autocmd FileType text,markdown,tex setlocal textwidth=80]]
    vim.cmd [[autocmd TermOpen * setlocal nonumber norelativenumber]]
vim.cmd [[augroup END]]

