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
    use 'rmehri01/onenord.nvim'
    use 'junegunn/gv.vim'
    use 'mattn/emmet-vim'
    use 'plasticboy/vim-markdown'
    use "ray-x/lsp_signature.nvim"
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
    use "L3MON4D3/LuaSnip"
    use "nvim-telescope/telescope-media-files.nvim"
    use "norcalli/nvim-colorizer.lua"
    use "windwp/nvim-ts-autotag"
    use "lukas-reineke/indent-blankline.nvim"
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use 'luukvbaal/nnn.nvim'
    use 'mzlogin/vim-markdown-toc'
    use 'ferrine/md-img-paste.vim'
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
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
end)

-- Colors
vim.cmd [[colorscheme onenord]]
opt.termguicolors = true
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
opt.updatetime = 250 -- Inactive time for CursorHold
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
map ('n', '<F3>', ':AsyncTask texpdf<CR>', { silent = true })
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

-- NNN mappings
map ('n', '<C-N>', ':NnnExplorer<CR>', { silent = true })
map ('n', '<Leader>rr', ':NnnPicker<CR>', { silent = true })

-- Trouble
map("n", "<leader>xx", "<cmd>TroubleToggle<cr>", {silent = true, noremap = true})
map("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", {silent = true, noremap = true})
map("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>", {silent = true, noremap = true})
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", {silent = true, noremap = true})
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", {silent = true, noremap = true})
map("n", "gR", "<cmd>Trouble lsp_references<cr>", {silent = true, noremap = true})

-- Custom text object: "around document". Useful to format/indent an entire file with gqad or =ad
map('o', 'ad', '<Cmd>normal! ggVG<CR>', {noremap = true})

-- Plugin-specific settings
g.ftplugin_sql_omni_key = '<C-K>' -- Remap to different key since Ctrl-C is for escape
g.sql_type_default = 'postgres' -- Change sql dialect to postgres
g.asyncrun_open = 6 -- Activate async task manager
g.asynctasks_extra_config = { '~/.config/nvim/.tasks' } -- Global tasks
g.vim_markdown_folding_disabled = 1
g.neoformat_only_msg_on_error = 1
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
" Update binds when sxhkdrc is updated.
autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
autocmd FileType markdown nnoremap <buffer> <leader>m :call mdip#MarkdownClipboardImage()<CR>
]], false)

-- Plugin configuration
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "cpp", "java", "python", "rust", "typescript", "javascript", "toml", "tsx", "lua", "bash"},
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
        disable = {"python"}
    },
    context_commentstring = {
        enable = true,
    },
    incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
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
    };
}

local function prequire(...)
local status, lib = pcall(require, ...)
if (status) then return lib end
    return nil
end

local luasnip = prequire('luasnip')

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
    elseif luasnip and luasnip.expand_or_jumpable() then
        return t("<Plug>luasnip-expand-or-jump")
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn['compe#complete']()
    end
    return ""
end
_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif luasnip and luasnip.jumpable(-1) then
        return t("<Plug>luasnip-jump-prev")
    else
        return t "<S-Tab>"
    end
    return ""
end

map("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map("i", "<C-E>", "<Plug>luasnip-next-choice", {})
map("s", "<C-E>", "<Plug>luasnip-next-choice", {})

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

local util = require 'lspconfig/util'

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
        rootMarkers = {".git/"},
        languages = efm_languages
    },
    init_options = {
        documentFormatting = true,
        codeAction = true
    },
    root_dir = function(fname)
      return util.root_pattern(".git")(fname) or vim.fn.getcwd()
    end;
})

local is_using_eslint = function(_, _, result, client_id)
    if is_cfg_present("/.eslintrc") then
        return
    end

    return vim.lsp.handlers["textDocument/publishDiagnostics"](_, _, result, client_id)
end

function _G.completions()
    local npairs = require("nvim-autopairs")
    if fn.pumvisible() == 1 then
        if fn.complete_info()["selected"] ~= -1 then
            return fn["compe#confirm"]("<CR>")
        end
    end
    return npairs.check_break_line_char()
end

require'lspconfig'.pylsp.setup{}
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

require("nvim-autopairs.completion.compe").setup({
    map_cr = true, --  map <CR> on insert mode
    map_complete = true, -- it will auto insert `(` after select function or method item
    auto_select = false,  -- auto select first item
})

require'nvim-web-devicons'.setup {
    default = true;
}

require('telescope').setup{
   defaults = {
      vimgrep_arguments = {
         "rg",
         "--color=never",
         "--no-heading",
         "--with-filename",
         "--line-number",
         "--column",
         "--smart-case",
      },
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
         horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
         },
         vertical = {
            mirror = false,
         },
         width = 0.87,
         height = 0.80,
         preview_cutoff = 120,
      },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = { "node_modules" },
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = { "absolute" },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      use_less = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
   },
   extensions = {
      media_files = {
         filetypes = { "png", "webp", "jpg", "jpeg" },
         find_cmd = "rg", -- find command (defaults to `fd`)
      },
   },
}
require("telescope").load_extension("media_files")
require('colorizer').setup()
require('nvim-ts-autotag').setup()
require('onenord').setup()
require("nnn").setup{
    auto_close = true,
    replace_netrw = "picker",
    windownav = {        -- window movement mappings to navigate out of nnn
        left = "<C-h>",
        right = "<C-l>"
    },
}
require'lspconfig'.emmet_ls.setup{}
require('gitsigns').setup {
    signs = {
        add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
        change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
    keymaps = {
        -- Default keymap options
        noremap = true,

        ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
        ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

        ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
        ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
        ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
        ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
        ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
        ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
        ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
        ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line{full=true}<CR>',
        ['n <leader>hS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
        ['n <leader>hU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

        -- Text objects
        ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
        ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
    },
    watch_gitdir = {
        interval = 1000,
        follow_files = true
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter_opts = {
        relative_time = false
    },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000,
    preview_config = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
    yadm = {
        enable = false
    },
}

require('lualine').setup {
  options = {
    theme = 'onenord',
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''}
  }
}

-- require "lsp_signature".setup()
