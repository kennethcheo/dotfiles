local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup({function(use)

    -- caches lua modules
    use {'lewis6991/impatient.nvim',
        config = function()
            require'impatient'.enable_profile()
        end,
    }

    use {'wbthomason/packer.nvim'}
    use {'nvim-lua/plenary.nvim'}

    -- lsp and completion support
    use {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require('config.treesitter')
        end,
        run = ':TSUpdate',
        event = 'BufRead',
    }

    use {'hrsh7th/nvim-cmp',
        config = function()         -- todo: lazy load
            require('config.cmp')
        end,
        event = 'InsertEnter',
    }
    use {'hrsh7th/cmp-nvim-lsp',
    }
    use {'neovim/nvim-lspconfig',   -- todo: configs, lazy load
        config = function()
            require('config.lsp')
        end,
    }

    -- UI
    use {
        'kyazdani42/nvim-tree.lua',
        config = function()
            require('config.nvim_tree')         -- todo: lazy load
        end,
        -- cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
    }

    use {
        'romgrk/barbar.nvim',
        event = 'BufEnter',
        --[[config = function()
            require('configs.barbar_nvim')     -- todo: configs
        end]]
    }

    use {
        'hoob3rt/lualine.nvim',
        config = function()
            require('lualine').setup()          -- todo: configs
        end,
        -- after = 'gruvbox.nvim',
    }

    --[[use {
        'lukas-reineke/indent-blankline.nvim',
        event = 'BufRead',
    }]]
    use {'lewis6991/gitsigns.nvim'}
    use {'kyazdani42/nvim-web-devicons'}
    use {'glepnir/dashboard-nvim',
        config = function()
            require('config.dashboard')
        end,
    }

    -- Quality of Life support
    -- TODO: project, which-key, dashboard, DAP, toggleterm
    use {
        'nvim-telescope/telescope.nvim',        -- todo: configs
        module = "telescope",
        cmd = "Telescope",
    }

    use {
        'terrortylor/nvim-comment',
        cmd = "CommentToggle",
        config = function()
            require('nvim_comment').setup()
        end
    }
    use {'machakann/vim-sandwich'}

    -- colorscheme
    use {'ellisonleao/gruvbox.nvim', requires = {'rktjmp/lush.nvim'}}

end,

    config = {
        -- floating window for command outputs
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'single' })
            end
        },
        compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua',
        profile = {
            enable = true,
            threshold = 1
        },
    }
})
