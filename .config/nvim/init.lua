local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
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
    use "terrortylor/nvim-comment"
    use "rafamadriz/friendly-snippets"
    use "nvim-telescope/telescope-media-files.nvim"
    use "norcalli/nvim-colorizer.lua"
    use "windwp/nvim-ts-autotag"
    use "lukas-reineke/indent-blankline.nvim"
    use 'nvim-treesitter/nvim-treesitter-textobjects'
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
vim.o.termguicolors = true
vim.g.lightline = {
    colorscheme = 'nord'
}

vim.o.shiftwidth = 4 -- # of spaces for autoindent
vim.o.softtabstop = 4 -- Pretend tab is removed when hitting <BS>
vim.o.expandtab = true -- Insert spaces when hitting <Tab> 
vim.o.autoindent = true-- Same indent as previous line

vim.wo.number = true -- Also show the current line instead of a 0
vim.wo.relativenumber = true -- Easier way to calculate lines

vim.o.hlsearch = false -- Turn off persistant highlighting
vim.o.ignorecase = true -- Ignore case when searching
vim.o.smartcase = true -- If first letter is uppercase, then make the search Case sensitive

vim.o.undofile = true -- Persistant backup file
vim.o.undolevels = 1000 -- Use a large number of undo levels
vim.o.undodir = '/home/kamui/.config/nvim/undodir' 

-- Misc
vim.o.helplang = 'ja,en' --Japanese help docs
vim.o.hidden = true -- Hide buffers instead of closing them
vim.o.mouse = 'a' -- Be able to use the mouse
vim.o.scrolloff = 8 -- So the cursor isn't all the way at the bottom
vim.o.splitbelow = true -- Split directions
vim.o.splitright = true 
vim.o.guicursor = 'i:block' -- Get rid of the ugly line cursor in insert mode
vim.o.wrap = true -- Wrap lines
vim.o.history = 1000 -- Bigger history size
vim.o.title = true -- Change title
vim.o.lazyredraw = true -- Don't redraw when executing macros
vim.o.showmode = false -- Since lightline already displays it
vim.o.completeopt = 'menuone,noselect'
vim.o.updatetime = 200 -- Inactive time for CursorHold
vim.o.shortmess = vim.o.shortmess .. 'c'

-- Leader key
vim.g.mapleader = ' '

-- Alternate Esc bind
vim.api.nvim_set_keymap("i", "<C-C>", "<Esc>", { silent = true })

-- Edit vimrc
vim.api.nvim_set_keymap('n', '<Leader>ev', ':new ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true })

-- Copy all text to system clipboard
vim.api.nvim_set_keymap('n', '<Leader>Y', ':%y+<CR>', { noremap = true })
-- Copy text to system clipboard
vim.api.nvim_set_keymap('n', '<Leader>y', '"+y', { noremap = true })
-- Paste from system clipboard
vim.api.nvim_set_keymap('n', '<Leader>p', '"+p', { noremap = true })

-- Moving through tabs
vim.api.nvim_set_keymap('n', '<S-H>', 'gT', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-L>', 'gt', { noremap = true })

-- Faster scrolling
vim.api.nvim_set_keymap('n', '<C-E>', '2<C-E>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-Y>', '2<C-Y>', { noremap = true })

-- Toggle spell check
vim.api.nvim_set_keymap('n', '<Leader>ts', ':set spell!', { noremap = true, silent = true })

-- Move between splits
vim.api.nvim_set_keymap('n', '<C-J>', '<C-W><C-J>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-K>', '<C-W><C-K>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-L>', '<C-W><C-L>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-H>', '<C-W><C-H>', { noremap = true })

-- Open url in browser
vim.api.nvim_set_keymap('n', 'gx', ':silent execute "!xdg-open " . shellescape("<cWORD>")<CR>', { noremap = true })

-- Close current buffer
vim.api.nvim_set_keymap('n', '<Leader>q', ':bd<CR>', { noremap = true, silent = true })

-- Close current window
vim.api.nvim_set_keymap('n', '<Leader>cw', '<C-W>c', { noremap = true, silent = true })

-- Faster way to write changes
vim.api.nvim_set_keymap('n', '<Leader>w', ':update<CR>', { noremap = true })
-- Faster way to quit
vim.api.nvim_set_keymap('n', '\\q', ':quit<CR>', { noremap = true })

-- Use tab to match pairs
vim.api.nvim_set_keymap('n', '<Tab>', '%', { noremap = true })
vim.api.nvim_set_keymap('v', '<Tab>', '%', { noremap = true })

-- Faster way to get into command line mode
vim.api.nvim_set_keymap('n', ';', ':', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>;', ';', { noremap = true })

-- Expected behavior when moving through wrapped lines
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true })

-- Strip whitespace of file
vim.api.nvim_set_keymap('n', '<Leader>ss', ':call StripWhitespace()<CR>', { noremap = true })
-- cd to the current file's folder
vim.api.nvim_set_keymap('n', '<Leader>cd', ':cd %:p:h<CR>', { noremap = true })

-- Move through command line history
vim.api.nvim_set_keymap('c', '<C-N>', '<Down>', { noremap = true })
vim.api.nvim_set_keymap('c', '<C-P>', '<Up>', { noremap = true })

-- Quickly move current line
vim.api.nvim_set_keymap('n', '[e', ':<c-u>execute "move -1-". v:count1<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', ']e', ':<c-u>execute "move +". v:count1<cr>', { noremap = true })

-- Tasks
vim.api.nvim_set_keymap('n', '<F4>', ':MarkdownPreview<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F5>', ':AsyncTask liveserver<CR>', { noremap = true, silent = true })

-- LSP mappings
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'K', ':Lspsaga hover_doc<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>rn', ':Lspsaga rename<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ca', ':Lspsaga code_action<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>cc', ':Lspsaga show_line_diagnostics<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>[d', ':Lspsaga diagnostic_jump_next<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>]d', ':Lspsaga diagnostic_jump_prev<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>pd', ':Lspsaga preview_definition<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-F>', '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-B>', '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>', { noremap = true, silent = true })

-- Quickfix mappings
vim.api.nvim_set_keymap('n', '[q', ':cprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']q', ':cnext<CR>', { noremap = true, silent = true })

-- Telescope mappings
vim.api.nvim_set_keymap('n', '<C-P>', '<cmd>lua require("telescope.builtin").find_files()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>ff', '<cmd>lua require("telescope.builtin").treesitter()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fb', '<cmd>lua require("telescope.builtin").buffers()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<CR>', { noremap = true })

-- Open up nvim tree
vim.api.nvim_set_keymap('n', '<C-N>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>rr', ':NvimTreeRefresh<CR>', { noremap = true, silent = true })

-- Plugin-specific settings
vim.g.ftplugin_sql_omni_key = '<C-K>' -- Remap to different key since Ctrl-C is for escape
vim.g.sql_type_default = 'postgres' -- Change sql dialect to postgres
vim.g.asyncrun_open = 6 -- Activate async task manager
vim.g.asynctasks_extra_config = { '~/.config/nvim/.tasks' } -- Global tasks
vim.g.vim_markdown_folding_disabled = 1
vim.g.neoformat_only_msg_on_error = 1
vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache' }
vim.g.nvim_tree_gitignore = 1 
vim.g.nvim_tree_auto_open = 0
vim.g.nvim_tree_auto_close = 1
vim.g.nvim_tree_show_icons = { git = 0, folders = 1, files = 1, folder_arrows = 1 }
vim.g.nord_borders = true
vim.g.indent_blankline_char = "▏"

-- User commands
vim.api.nvim_exec([[
" Commonly mistyped commands
command! W w
command! Q q
" Delete all buffers except the current one
command! Bonly %bd|e#
" Format code
command! Format execute 'lua vim.lsp.buf.formatting()' 
]], false)

-- Autocommands
vim.api.nvim_exec([[
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
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif vim.fn.call("vsnip#available", {1}) == 1 then
        return t "<Plug>(vsnip-expand-or-jump)"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn['compe#complete']()
    end
end
_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
        return t "<Plug>(vsnip-jump-prev)"
    else
        return t "<S-Tab>"
    end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

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
            diagnostics = {
                enable = true,
                disabled = {"unresolved-proc-macro"},
                enableExperimental = true,
            },
        }
    }
}

require'lspconfig'.tsserver.setup {
    on_attach = function(client)
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
local efm_root_markers = { 'package.json', '.git/' }
local efm_config = os.getenv('HOME') .. '/.config/nvim/efm_config.yaml'
local efm_languages = {
    yaml = { prettier },
    markdown = { prettier },
    javascript = { eslint, prettier },
    javascriptreact = { eslint, prettier },
    typescript = { eslint, prettier },
    typescriptreact = { eslint, prettier },
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
    filetype = {
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
    root_dir = require'lspconfig'.util.root_pattern(unpack(efm_root_markers)),
    settings = {
        rootMarkers = efm_root_markers,
        languages = efm_languages
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
    if vim.fn.pumvisible() == 1 then
        if vim.fn.complete_info()["selected"] ~= -1 then
            return vim.fn["compe#confirm"]("<CR>")
        end
    end
    return npairs.check_break_line_char()
end
vim.api.nvim_set_keymap("i", "<CR>", "v:lua.completions()", {expr = true})

require'nvim-web-devicons'.setup {
    default = true;
}
require('nvim_comment').setup()
require('telescope').load_extension('media_files')
require('colorizer').setup()
require('gitsigns').setup()
require('nvim-ts-autotag').setup()
require('nord').set()
