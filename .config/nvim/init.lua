local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt
local exec = vim.api.nvim_exec

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.api.nvim_command('packadd packer.nvim')
end

require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'windwp/nvim-autopairs'
    use 'shaunsingh/nord.nvim'
    use 'itchyny/lightline.vim'
    use 'junegunn/gv.vim'
    use 'mattn/emmet-vim'
    use 'plasticboy/vim-markdown'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-surround'
    use 'vim-jp/vimdoc-ja'
    use 'mechatroner/rainbow_csv'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-compe'
    use 'glepnir/lspsaga.nvim'
    use "onsails/lspkind-nvim"
    use "sbdchd/neoformat"
    use "kyazdani42/nvim-web-devicons"
    use "b3nj5m1n/kommentary"
    use "rafamadriz/friendly-snippets"
    use "nvim-telescope/telescope-media-files.nvim"
    use "norcalli/nvim-colorizer.lua"
    use "windwp/nvim-ts-autotag"
    use "lukas-reineke/indent-blankline.nvim"
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {
            }
        end
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use {
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install'
    }
    use {
        'skywind3000/asynctasks.vim',
        requires = {'skywind3000/asyncrun.vim'}
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
    use {
        'hrsh7th/vim-vsnip',
        requires = {'hrsh7th/vim-vsnip-integ'}
    }
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
    }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons'
        }
    }
end)

-- Colors
opt.termguicolors = true
g.lightline = {
    colorscheme = 'nord'
}

opt.shiftwidth = 4 -- # of spaces for autoindent
opt.softtabstop = 4 -- Pretend tab is removed when hitting <BS>
opt.expandtab = true -- Insert spaces when hitting <Tab>
opt.autoindent = true-- Same indent as previous line

opt.number = true -- Also show the current line instead of a 0
opt.relativenumber = true -- Easier way to calculate lines

opt.hlsearch = false -- Turn off persistant highlighting
opt.ignorecase = true -- Ignore case when searching
opt.smartcase = true -- If first letter is uppercase, then make the search Case sensitive

opt.undofile = true -- Persistant backup file
opt.undolevels = 1000 -- Use a large number of undo levels
opt.undodir = '/home/kamui/.config/nvim/undodir'

-- Misc
opt.helplang = 'ja,en' --Japanese help docs
opt.hidden = true -- Hide buffers instead of closing them
opt.mouse = 'a' -- Be able to use the mouse
opt.scrolloff = 8 -- So the cursor isn't all the way at the bottom
opt.splitbelow = true -- Split directions
opt.splitright = true
opt.guicursor = 'i:block' -- Get rid of the ugly line cursor in insert mode
opt.wrap = false -- Wrap lines
opt.history = 1000 -- Bigger history size
opt.title = true -- Change title
opt.lazyredraw = true -- Don't redraw when executing macros
opt.showmode = false -- Since lightline already displays it
opt.completeopt = 'menuone,noselect'
opt.updatetime = 200 -- Inactive time for CursorHold
opt.shortmess:append({c = true})

-- Leader key
g.mapleader = ' '

local map = function(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


-- Alternate Esc bind
map ("i", "<C-C>", "<Esc>", { silent = true })

-- Edit vimrc
map ('n', '<Leader>ev', ':new ~/.config/nvim/init.lua<CR>', { silent = true })

-- Copy all text to system clipboard
map ('n', '<Leader>Y', ':%y+<CR>')
-- Copy text to system clipboard
map ('n', '<Leader>y', '"+y')
-- Paste from system clipboard
map ('n', '<Leader>p', '"+p')
-- Copy till end of line
map ('n', 'Y', 'y$')

-- Switch buffers with Left and Right keys
map ('n', '<left>', ':bp<cr>')
map ('n', '<right>', ':bn<cr>')

-- Open git status
map ('n', '<Leader>gs', ':Git status<CR>')
-- Git Add evetything
map ('n', '<Leader>ga', ':Git add .<CR>')
-- Git commit message
map ('n', '<Leader>gc', ':Git commit <CR>')
-- Git log
map ('n', '<Leader>gl', ':Git log <CR>')

-- Moving through tabs
map ('n', '<S-H>', 'gT')
map ('n', '<S-L>', 'gt')

-- Faster scrolling
map ('n', '<C-E>', '2<C-E>')
map ('n', '<C-Y>', '2<C-Y>')

-- Toggle spell check
map ('n', '<Leader>ts', ':set spell!', { silent = true })

-- Move between splits
map ('n', '<C-J>', '<C-W><C-J>')
map ('n', '<C-K>', '<C-W><C-K>')
map ('n', '<C-L>', '<C-W><C-L>')
map ('n', '<C-H>', '<C-W><C-H>')

-- Open url in browser
map ('n', 'gx', ':silent execute "!xdg-open " . shellescape("<cWORD>")<CR>')

-- Close current buffer
map ('n', '<Leader>q', ':bd<CR>', { silent = true })

-- Close current window
map ('n', '<Leader>cw', '<C-W>c', { silent = true })

-- Faster way to write changes
map ('n', '<Leader>w', ':update<CR>')
-- Faster way to quit
map ('n', '\\q', ':quit<CR>')

-- Use tab to match pairs
map ('n', '<Tab>', '%')
map ('v', '<Tab>', '%')

-- Faster way to get into command line mode
map ('n', ';', ':')
map ('n', ':', ';')

-- Expected behavior when moving through wrapped lines
map ('n', 'j', 'gj')
map ('n', 'k', 'gk')

-- Strip whitespace of file
map ('n', '<Leader>ss', ':%s/\\s\\+$//e<CR>')
-- cd to the current file's folder
map ('n', '<Leader>cd', ':cd %:p:h<CR>')

-- Move through command line history
map ('c', '<C-N>', '<Down>')
map ('c', '<C-P>', '<Up>')

-- Quickly move current line
map ('n', '[e', ':<c-u>execute "move -1-". v:count1<cr>')
map ('n', ']e', ':<c-u>execute "move +". v:count1<cr>')

-- Tasks
map ('n', '<F4>', ':MarkdownPreview<CR>', { silent = true })
map ('n', '<F5>', ':AsyncTask liveserver<CR>', { silent = true })

-- LSP mappings
map ('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { silent = true })
map ('n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>', { silent = true })
map ('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { silent = true })
map ('n', 'K', ':Lspsaga hover_doc<CR>', { silent = true })
map ('n', '<Leader>rn', ':Lspsaga rename<CR>', { silent = true })
map ('n', '<Leader>ca', ':Lspsaga code_action<CR>', { silent = true })
map ('n', '<Leader>cc', ':Lspsaga show_line_diagnostics<CR>', { silent = true })
map ('n', '<Leader>[d', ':Lspsaga diagnostic_jump_next<CR>', { silent = true })
map ('n', '<Leader>]d', ':Lspsaga diagnostic_jump_prev<CR>', { silent = true })
map ('n', '<C-F>', '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', { silent = true })
map ('n', '<C-B>', '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>', { silent = true })

-- Quickfix mappings
map ('n', '[q', ':cprevious<CR>', { silent = true })
map ('n', ']q', ':cnext<CR>', { silent = true })
map ('n', 'cq', ':cclose<CR>', { silent = true })

-- Telescope mappings
map ('n', '<C-P>', '<cmd>lua require("telescope.builtin").find_files()<CR>')
map ('n', '<Leader>ff', '<cmd>lua require("telescope.builtin").treesitter()<CR>')
map ('n', '<Leader>fb', '<cmd>lua require("telescope.builtin").buffers()<CR>')
map ('n', '<Leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<CR>')
map ('n', '<Leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<CR>')

-- Open up nvim tree
map ('n', '<C-N>', ':NvimTreeToggle<CR>', { silent = true })
map ('n', '<Leader>rr', ':NvimTreeRefresh<CR>', { silent = true })

-- Plugin-specific settings
g.ftplugin_sql_omni_key = '<C-K>' -- Remap to different key since Ctrl-C is for escape
g.sql_type_default = 'postgres' -- Change sql dialect to postgres
g.asyncrun_open = 6 -- Activate async task manager
g.asynctasks_extra_config = { '~/.config/nvim/.tasks' } -- Global tasks
g.vim_markdown_folding_disabled = 1
g.neoformat_only_msg_on_error = 1
g.nvim_tree_ignore = { '.git', 'node_modules', '.cache' }
g.nvim_tree_gitignore = 1
g.nvim_tree_auto_open = 0
g.nvim_tree_auto_close = 1
g.nvim_tree_show_icons = { git = 0, folders = 1, files = 1, folder_arrows = 1 }
g.nord_borders = true
g.indent_blankline_char = "▏"
g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard", "packer" }
g.indent_blankline_buftype_exclude = { "terminal" }

-- User commands
exec([[
" Commonly mistyped commands
command! W w
command! Q q
" Delete all buffers except the current one
command! Bonly %bd|e#
" Format code
command! Format execute 'lua vim.lsp.buf.formatting()'
]], false)

-- Autocommands
exec([[
augroup mygroup
autocmd!
" Filetype corrections
autocmd BufNewFile,BufRead .tasks set syntax=dosini
" Format on save
autocmd BufWritePost * :Format
augroup end
]], false)

-- Plugin configuration
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "cpp", "java", "python", "rust", "typescript", "javascript", "toml", "tsx" },
    link,
    highlight = {
        enable = true,
    },
    indent = {
        enable = true
    },
    context_commentstring = {
        enable = true,
    }
}

require'nvim-treesitter.configs'.setup {
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
    },
}

-- compe.nvim setup
require'compe'.setup {
    enabled = true; autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'always';
    throttle_time = 80;
    source_timeout = 200;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = true;

    source = {
        path = true;
        nvim_lsp = true;
        vsnip = true;
    };
}

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = fn.col('.') - 1
    if col == 0 or fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif fn.call("vsnip#available", {1}) == 1 then
        return t "<Plug>(vsnip-expand-or-jump)"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return fn['compe#complete']()
    end
end
_G.s_tab_complete = function()
    if fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif fn.call("vsnip#jumpable", {-1}) == 1 then
        return t "<Plug>(vsnip-jump-prev)"
    else
        return t "<S-Tab>"
    end
end

map ("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
map ("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
map ("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map ("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    }
}

-- LSP servers
require'lspconfig'.rust_analyzer.setup {
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
		command = "clippy"
	    },
            diagnostics = {
                enable = true,
                disabled = {"unresolved-proc-macro"},
                enableExperimental = true,
            },
        }
    }
}

require'lspconfig'.tsserver.setup {
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
    end
}

-- eslint and prettier
local eslint = {
    lintCommand = 'eslint_d --stdin --stdin-filename ${INPUT} -f unix',
    lintStdin = true,
    lintIgnoreExitCode = true
}

local prettier = {
    formatCommand = 'prettier --find-config-path --stdin-filepath ${INPUT}',
    formatStdin = true
}

local efm_log_dir = '/tmp/'
local efm_config = os.getenv('HOME') .. '/.config/nvim/efm_config.yaml'
local efm_languages = {
    yaml = { prettier },
    markdown = { prettier },
    javascript = { eslint, prettier },
    javascriptreact = { eslint, prettier },
    typescript = { prettier, eslint },
    typescriptreact = { prettier, eslint},
    css = { prettier },
    scss = { prettier },
    json = { prettier },
    graphql = { prettier },
    html = { prettier }
}

require'lspconfig'.efm.setup({
    cmd = {
        "efm-langserver",
        "-c",
        efm_config,
        "-logfile",
        efm_log_dir .. "efm.log"
    },
    filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'yaml',
        'json',
        'markdown',
        'css',
        'scss',
        'graphql',
        'html'
    },
    settings = {
        languages = efm_languages
    },
    init_options = {
        documentFormatting = true,
        codeAction = true
    }
})

local is_using_eslint = function(_, _, result, client_id)
    if is_cfg_present("/.eslintrc") then
        return
    end

    return vim.lsp.handlers["textDocument/publishDiagnostics"](_, _, result, client_id)
end

require'lspconfig'.pyright.setup{}
require'lspconfig'.clangd.setup{}

-- LSP Misc
require'lspsaga'.init_lsp_saga {
    use_saga_diagnostic_sign = true,
    error_sign = '',
    warn_sign = '',
    infor_sign = '',
    code_action_prompt = {
        sign = false,
    }
}
require("lspkind").init()

require('nvim-autopairs').setup()
function _G.completions()
    local npairs = require("nvim-autopairs")
    if fn.pumvisible() == 1 then
        if fn.complete_info()["selected"] ~= -1 then
            return fn["compe#confirm"]("<CR>")
        end
    end
    return npairs.check_break_line_char()
end

require("nvim-autopairs.completion.compe").setup({
    map_cr = true, --  map <CR> on insert mode
    map_complete = true, -- it will auto insert `(` after select function or method item
    auto_select = false,  -- auto select first item
})

require'nvim-web-devicons'.setup {
    default = true;
}
require('telescope').load_extension('media_files')
require('colorizer').setup()
require('gitsigns').setup {
      keymaps = {
      -- Default keymap options
      buffer = true,
      noremap = true,
      ["n ]c"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'" },
      ["n [c"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'" },
      ["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
      ["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
      ["n <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
      ["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
      ["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line()<CR>',
   },
   sign_priority = 5,
   signs = {
      add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
      change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
      changedelete = { hl = "DiffChange", text = "~", numhl = "GitSignsChangeNr" },
      delete = { hl = "DiffDelete", text = "_", numhl = "GitSignsDeleteNr" },
      topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
   },
}
require('nvim-ts-autotag').setup()
require('nord').set()
