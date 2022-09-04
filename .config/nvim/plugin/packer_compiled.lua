-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/justin/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/justin/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/justin/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/justin/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/justin/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    config = { "\27LJ\2\n�\4\0\0\f\0\23\0<6\0\0\0'\2\1\0B\0\2\0029\1\2\0009\1\3\0015\3\4\0B\1\2\1'\1\5\0006\2\6\0009\2\a\0029\2\b\2\18\4\1\0B\2\2\2\15\0\2\0X\3\a�6\2\0\0'\4\t\0B\2\2\0029\2\n\0025\4\v\0=\1\f\4B\2\2\0016\2\0\0'\4\t\0B\2\2\0029\2\n\2B\2\1\0015\2\15\0006\3\6\0009\3\r\0036\5\0\0'\a\14\0B\5\2\0A\3\0\2=\3\16\0026\3\6\0009\3\r\0036\5\0\0'\a\17\0B\5\2\0A\3\0\2=\3\18\0026\3\6\0009\3\r\0036\5\0\0'\a\19\0B\5\2\0A\3\0\2=\3\20\0026\3\21\0\18\5\2\0B\3\2\4H\6\4�9\b\22\0\18\n\6\0\18\v\a\0B\b\3\1F\6\3\3R\6�K\0\1\0\17add_snippets\npairs\blua-me.modules.completion.snippets.lua_snips\rmarkdown,me.modules.completion.snippets.markdown\vpython\1\0\0*me.modules.completion.snippets.python\15tbl_values\npaths\1\0\0\14lazy_load luasnip.loaders.from_vscode\16isdirectory\afn\bvim\28~/.config/nvim/snippets\1\0\2\25store_selection_keys\n<C-S>\18update_events\29TextChanged,TextChangedI\15set_config\vconfig\fluasnip\frequire\0" },
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["bufferline.nvim"] = {
    config = { "\27LJ\2\n�\1\0\0\6\0\t\0\0186\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\3\0004\4\3\0005\5\4\0>\5\1\4=\4\5\3=\3\a\2B\0\2\0016\0\0\0'\2\b\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nscope\foptions\1\0\0\foffsets\1\0\3\rfiletype\rneo-tree\ttext\18File Explorer\15text_align\vcenter\1\0\3\15close_icon\b\fnumbers\14buffer_id\20separator_style\nthick\nsetup\15bufferline\frequire\0" },
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  ["clangd_extensions.nvim"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/clangd_extensions.nvim",
    url = "https://github.com/p00f/clangd_extensions.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-doxygen"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/cmp-doxygen",
    url = "https://github.com/paopaol/cmp-doxygen"
  },
  ["cmp-fish"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/cmp-fish",
    url = "https://github.com/mtoohey31/cmp-fish"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["conflict-marker.vim"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/conflict-marker.vim",
    url = "https://github.com/rhysd/conflict-marker.vim"
  },
  ["dashboard-nvim"] = {
    config = { "\27LJ\2\n�\r\0\0\a\0\19\0\0316\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\1'\3\4\0B\1\2\2'\2\6\0=\2\5\0005\2\b\0=\2\a\0004\2\a\0005\3\n\0>\3\1\0025\3\v\0>\3\2\0025\3\f\0>\3\3\0025\3\r\0>\3\4\0025\3\14\0>\3\5\0025\3\15\0'\4\16\0\18\5\1\0'\6\17\0&\4\6\4=\4\18\3>\3\6\2=\2\t\0K\0\1\0\vaction\r/.config\29Telescope dotfiles path=\1\0\3\ticon\n  \tdesc-Open Personal dotfiles                  \rshortcut\fSPC f d\1\0\4\ticon\n  \tdesc-Find  word                              \vaction\24Telescope live_grep\rshortcut\fSPC f w\1\0\4\ticon\n  \tdesc-File Browser                            \vaction\fNeotree\rshortcut\fSPC f b\1\0\4\ticon\n  \tdesc-Find  File                              \vaction\25Telescope find_files\rshortcut\fSPC f f\1\0\4\ticon\n  \tdesc-Recently opened files                   \vaction\23Telescope oldfiles\rshortcut\fSPC f h\1\0\4\ticon\n  \tdesc.Recently latest session                  \vaction\16SessionLoad\rshortcut\fSPC s l\18custom_center\1\a\0\0�\1 ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗�\1 ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║�\1 ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║�\1 ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║�\1 ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║�\1 ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝\18custom_header\14telescope\22default_executive\tHOME\vgetenv\aos\14dashboard\frequire\0" },
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/dashboard-nvim",
    url = "https://github.com/glepnir/dashboard-nvim"
  },
  ["diffview.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rdiffview\frequire\0" },
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  ["dressing.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rdressing\frequire\0" },
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/dressing.nvim",
    url = "https://github.com/stevearc/dressing.nvim"
  },
  ["editorconfig-vim"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/editorconfig-vim",
    url = "https://github.com/editorconfig/editorconfig-vim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["glow.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/justin/.local/share/nvim/site/pack/packer/opt/glow.nvim",
    url = "https://github.com/ellisonleao/glow.nvim"
  },
  ["leap.nvim"] = {
    config = { "\27LJ\2\n�\1\0\0\3\0\t\0\0146\0\0\0'\2\1\0B\0\2\0029\1\2\0B\1\1\0019\1\3\0009\1\4\1'\2\6\0=\2\5\0019\1\3\0009\1\4\1'\2\b\0=\2\a\1K\0\1\0\f<s-tab>\15prev_match\n<tab>\15next_match\17special_keys\topts\24set_default_keymaps\tleap\frequire\0" },
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/leap.nvim",
    url = "https://github.com/ggandor/leap.nvim"
  },
  ["lsp_signature.nvim"] = {
    config = { "\27LJ\2\n`\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\20floating_window\1\16hint_enable\2\nsetup\18lsp_signature\frequire\0" },
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    commands = { "Lspsaga" },
    config = { "\27LJ\2\nl\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\23finder_action_keys\1\0\0\1\0\1\topen\t<CR>\18init_lsp_saga\flspsaga\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/justin/.local/share/nvim/site/pack/packer/opt/lspsaga.nvim",
    url = "https://github.com/glepnir/lspsaga.nvim"
  },
  ["lua-dev.nvim"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/lua-dev.nvim",
    url = "https://github.com/folke/lua-dev.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n�\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\15extensions\1\5\0\0\rneo-tree\rfugitive\15toggleterm\16nvim-dap-ui\foptions\1\0\0\1\0\1\ntheme\15tokyonight\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mason.nvim"] = {
    config = { "\27LJ\2\n�\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\aui\1\0\0\nicons\1\0\0\1\0\3\21server_installed\b✓\23server_uninstalled\b✗\19server_pending\b➜\nsetup\nmason\frequire\0" },
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["neo-tree.nvim"] = {
    commands = { "Neotree", "NeoTreeFocusToggle" },
    config = { "\27LJ\2\n�\2\0\0\6\0\18\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\14\0005\3\b\0005\4\3\0005\5\4\0=\5\5\0045\5\6\0=\5\a\4=\4\t\0035\4\v\0005\5\n\0=\5\f\4=\4\r\3=\3\15\0025\3\17\0005\4\16\0=\4\f\3=\3\r\2B\0\2\1K\0\1\0\1\0\0\1\0\2\n<C-V>\16open_vsplit\n<C-X>\15open_split\15filesystem\1\0\0\vwindow\rmappings\1\0\0\1\0\1\6F\17clear_filter\19filtered_items\1\0\1\24follow_current_file\2\15never_show\1\2\0\0\14.DS_Store\17hide_by_name\1\3\0\0\t.git\v*.pyc$\1\0\1\18hide_dotfiles\1\nsetup\rneo-tree\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/justin/.local/share/nvim/site/pack/packer/opt/neo-tree.nvim",
    url = "https://github.com/nvim-neo-tree/neo-tree.nvim"
  },
  neoformat = {
    commands = { "Neoformat" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/justin/.local/share/nvim/site/pack/packer/opt/neoformat",
    url = "https://github.com/sbdchd/neoformat"
  },
  neogen = {
    config = { "\27LJ\2\n�\1\0\0\6\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\a\0005\4\5\0005\5\4\0=\5\6\4=\4\b\3=\3\t\2B\0\2\1K\0\1\0\14languages\vpython\1\0\0\rtemplate\1\0\0\1\0\1\26annotation_convention\22google_docstrings\1\0\1\19snippet_engine\fluasnip\nsetup\vneogen\frequire\0" },
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/neogen",
    url = "https://github.com/danymat/neogen"
  },
  neogit = {
    config = { "\27LJ\2\nz\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\17integrations\1\0\1\rdiffview\2\1\0\1 disable_commit_confirmation\2\nsetup\vneogit\frequire\0" },
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/neogit",
    url = "https://github.com/TimUntersberger/neogit"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n@\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0" },
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\n�\1\0\0\b\0\b\2!6\0\0\0006\2\1\0009\2\2\0029\2\3\2)\4\0\0B\2\2\0A\0\0\3\b\1\0\0X\2\20�6\2\1\0009\2\2\0029\2\4\2)\4\0\0\23\5\1\0\18\6\0\0+\a\2\0B\2\5\2:\2\1\2\18\4\2\0009\2\5\2\18\5\1\0\18\6\1\0B\2\4\2\18\4\2\0009\2\6\2'\5\a\0B\2\3\2\n\2\0\0X\2\2�+\2\1\0X\3\1�+\2\2\0L\2\2\0\a%s\nmatch\bsub\23nvim_buf_get_lines\24nvim_win_get_cursor\bapi\bvim\vunpack\0\2-\0\1\4\1\2\0\5-\1\0\0009\1\0\0019\3\1\0B\1\2\1K\0\1\0\1�\tbody\15lsp_expand�\2\0\1\3\4\a\0,-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4�-\1\0\0009\1\1\1B\1\1\1X\1\"�-\1\1\0\15\0\1\0X\2\t�-\1\1\0009\1\2\1B\1\1\2\15\0\1\0X\2\4�-\1\1\0009\1\3\1B\1\1\1X\1\22�-\1\2\0\15\0\1\0X\2\t�-\1\2\0009\1\4\1B\1\1\2\15\0\1\0X\2\4�-\1\2\0009\1\5\1B\1\1\1X\1\n�-\1\3\0B\1\1\2\15\0\1\0X\2\4�-\1\0\0009\1\6\1B\1\1\1X\1\2�\18\1\0\0B\1\1\1K\0\1\0\0�\1�\2�\3�\rcomplete\14jump_next\rjumpable\19expand_or_jump\23expand_or_jumpable\21select_next_item\fvisible�\1\0\1\4\3\5\0'-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4�-\1\0\0009\1\1\1B\1\1\1X\1\29�-\1\1\0\15\0\1\0X\2\v�-\1\1\0009\1\2\1)\3��B\1\2\2\15\0\1\0X\2\5�-\1\1\0009\1\3\1)\3��B\1\2\1X\1\15�-\1\2\0\15\0\1\0X\2\n�-\1\2\0009\1\2\1+\3\2\0B\1\2\2\15\0\1\0X\2\4�-\1\2\0009\1\4\1B\1\1\1X\1\2�\18\1\0\0B\1\1\1K\0\1\0\0�\1�\2�\14jump_prev\tjump\rjumpable\21select_prev_item\fvisible�\a\1\0\r\0005\0|6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0023\3\4\0009\4\5\0005\6\t\0005\a\a\0003\b\6\0=\b\b\a=\a\n\0065\a\14\0006\b\0\0'\n\v\0B\b\2\0029\b\f\b5\n\r\0B\b\2\2=\b\15\a=\a\16\0065\a\20\0009\b\17\0009\n\17\0009\n\18\n)\f��B\n\2\0025\v\19\0B\b\3\2=\b\21\a9\b\17\0009\n\17\0009\n\18\n)\f\4\0B\n\2\0025\v\22\0B\b\3\2=\b\23\a9\b\17\0009\b\24\bB\b\1\2=\b\25\a9\b\17\0009\b\24\bB\b\1\2=\b\26\a9\b\17\0003\n\27\0005\v\28\0B\b\3\2=\b\29\a9\b\17\0003\n\30\0005\v\31\0B\b\3\2=\b \a9\b\17\0009\b!\bB\b\1\2=\b\"\a9\b\17\0009\b\24\bB\b\1\2=\b#\a=\a\17\0069\a$\0009\a%\a4\t\6\0005\n&\0>\n\1\t5\n'\0>\n\2\t5\n(\0>\n\3\t5\n)\0>\n\4\t5\n*\0>\n\5\t4\n\3\0005\v+\0>\v\1\n5\v,\0>\v\2\nB\a\3\2=\a%\6B\4\2\0019\4\5\0009\4-\4'\6.\0005\a0\0009\b\17\0009\b/\b9\b-\bB\b\1\2=\b\17\a4\b\3\0005\t1\0>\t\1\b=\b%\aB\4\3\0019\4\5\0009\4-\4'\0062\0005\a3\0009\b\17\0009\b/\b9\b-\b4\n\0\0B\b\2\2=\b\17\a9\b$\0009\b%\b4\n\3\0005\v4\0>\v\1\nB\b\2\2=\b%\aB\4\3\0012\0\0�K\0\1\0\1\0\1\tname\fcmdline\1\0\0\6:\1\0\1\tname\vbuffer\1\0\0\vpreset\6/\fcmdline\1\0\1\tname\tpath\1\0\1\tname\vbuffer\1\0\1\tname\tfish\1\0\1\tname\rnvim_lua\1\0\1\tname\fdoxygen\1\0\1\tname\fluasnip\1\0\1\tname\rnvim_lsp\fsources\vconfig\n<C-c>\t<CR>\fconfirm\f<S-TAB>\1\3\0\0\6i\6s\0\n<Tab>\1\3\0\0\6i\6s\0\v<DOWN>\t<UP>\nabort\n<C-f>\1\3\0\0\6i\6c\n<C-b>\1\0\0\1\3\0\0\6i\6c\16scroll_docs\fmapping\15formatting\vformat\1\0\0\1\0\2\rmaxwidth\0032\14with_text\2\15cmp_format\flspkind\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\0\vneogen\fluasnip\bcmp\frequire\0" },
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-dap"] = {
    commands = { "DapUiToggle" },
    config = { "\27LJ\2\n�\1\0\0\6\0\t\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\0\0'\2\3\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0006\3\0\0'\5\1\0B\3\2\0029\3\b\0034\4\0\0B\0\4\1K\0\1\0\vtoggle\16DapUiToggle\29nvim_create_user_command\bapi\bvim\26nvim-dap-virtual-text\nsetup\ndapui\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/justin/.local/share/nvim/site/pack/packer/opt/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    commands = { "DapUiToggle" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/justin/.local/share/nvim/site/pack/packer/opt/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-dap-virtual-text"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/nvim-dap-virtual-text",
    url = "https://github.com/theHamsta/nvim-dap-virtual-text"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n�\a\0\0\r\0014\0r6\0\0\0'\2\1\0B\0\2\0029\0\2\0006\2\3\0009\2\4\0029\2\5\0029\2\6\2B\2\1\0A\0\0\0026\1\0\0'\3\a\0B\1\2\0025\2\b\0-\3\0\0=\3\t\2=\0\n\0026\3\0\0'\5\v\0B\3\2\0029\3\f\0035\5\19\0005\6\18\0-\a\0\0>\a\1\0066\a\3\0009\a\r\a'\t\14\0\18\n\0\0005\v\16\0005\f\15\0=\f\17\vB\a\4\2=\a\n\6=\6\20\5B\3\2\0016\3\21\0009\5\17\0B\3\2\0019\3\22\0019\3\f\0036\5\0\0'\a\23\0B\5\2\0029\5\f\0055\a\27\0005\b\25\0005\t\24\0=\t\26\b=\b\28\a=\2\29\aB\5\2\0A\3\0\0019\3\30\0019\3\f\0035\5$\0005\6#\0005\a\"\0006\b\0\0'\n\31\0B\b\2\0029\b \b9\b!\bB\b\1\2=\b!\a=\a \6=\6%\5-\6\0\0=\6\t\5=\0\n\5B\3\2\0016\3&\0005\5'\0B\3\2\4X\6\4�8\b\a\0019\b\f\b\18\n\2\0B\b\2\1E\6\3\3R\6�6\3\0\0'\5(\0B\3\2\0029\4\f\0035\0062\0004\a\a\0009\b)\0039\b*\b9\b+\b>\b\1\a9\b)\0039\b,\b9\b-\b>\b\2\a9\b)\0039\b,\b9\b.\b>\b\3\a9\b)\0039\b,\b9\b/\b>\b\4\a9\b)\0039\b,\b9\b0\b>\b\5\a9\b)\0039\b,\b9\b1\b>\b\6\a=\a3\6B\4\2\1K\0\1\0\0�\fsources\1\0\1\14autostart\2\15shellcheck\rhadolint\tfish\fgitlint\vflake8\16diagnostics\rgitsigns\17code_actions\rbuiltins\fnull-ls\1\b\0\0\fpyright\rdockerls\nvimls\ncmake\vbashls\rmarksman\ntaplo\vipairs\rsettings\1\0\0\1\0\0\1\0\0\fschemas\tjson\16schemastore\vjsonls\rlsponfig\flibrary\1\0\0\fplugins\1\0\0\1\4\0\0\20nvim-treesitter\17plenary.nvim\19telescope.nvim\flua-dev\16sumneko_lua\nprint\vserver\1\0\0\1\0\0\19offsetEncoding\1\0\0\1\2\0\0\vutf-16\nforce\15tbl_extend\nsetup\22clangd_extensions\17capabilities\14on_attach\1\0\0\14lspconfig\29make_client_capabilities\rprotocol\blsp\bvim\24update_capabilities\17cmp_nvim_lsp\frequire\0" },
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-neoclip.lua"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\fneoclip\frequire\0" },
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/nvim-neoclip.lua",
    url = "https://github.com/AckslD/nvim-neoclip.lua"
  },
  ["nvim-notify"] = {
    config = { "\27LJ\2\n2\0\0\4\0\3\0\0066\0\0\0006\1\2\0'\3\1\0B\1\2\2=\1\1\0K\0\1\0\frequire\vnotify\bvim\0" },
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n�\5\0\0\6\0\29\0%6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0005\4\t\0=\4\n\3=\3\v\0025\3\f\0005\4\r\0=\4\14\3=\3\15\0025\3\19\0005\4\16\0005\5\17\0=\5\18\4=\4\20\0035\4\21\0005\5\22\0=\5\23\0045\5\24\0=\5\25\4=\4\26\3=\3\27\2B\0\2\0016\0\0\0'\2\28\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\23treesitter-context\16textobjects\tswap\18swap_previous\1\0\1\14<leader>S\21@parameter.inner\14swap_next\1\0\1\14<leader>s\21@parameter.inner\1\0\1\venable\2\vselect\1\0\0\fkeymaps\1\0\b\aac\17@class.outer\aic\17@class.inner\ail\16@loop.inner\aal\16@loop.outer\aaf\20@function.outer\aia\21@parameter.inner\aif\20@function.inner\aaa\21@parameter.outer\1\0\2\venable\2\14lookahead\2\17query_linter\16lint_events\1\3\0\0\rBufWrite\15CursorHold\1\0\2\venable\2\21use_virtual_text\2\fmatchup\25disable_virtual_text\1\2\0\0\vpython\1\0\1\venable\2\14highlight\1\0\1\venable\2\21ensure_installed\1\0\0\1\14\0\0\bcpp\6c\tbash\blua\vpython\tfish\ncmake\fcomment\njsonc\tyaml\15dockerfile\nquery\rmarkdown\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/nvim-treesitter-context",
    url = "https://github.com/lewis6991/nvim-treesitter-context"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["project.nvim"] = {
    config = { "\27LJ\2\n>\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\17project_nvim\frequire\0" },
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/project.nvim",
    url = "https://github.com/ahmedkhalf/project.nvim"
  },
  ["schemastore.nvim"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/schemastore.nvim",
    url = "https://github.com/b0o/schemastore.nvim"
  },
  ["scope.nvim"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/scope.nvim",
    url = "https://github.com/tiagovla/scope.nvim"
  },
  ["sqlite.lua"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/justin/.local/share/nvim/site/pack/packer/opt/sqlite.lua",
    url = "https://github.com/kkharji/sqlite.lua"
  },
  ["symbols-outline.nvim"] = {
    commands = { "SymbolsOutline" },
    config = { "\27LJ\2\nR\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\17auto_preview\1\nsetup\20symbols-outline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/justin/.local/share/nvim/site/pack/packer/opt/symbols-outline.nvim",
    url = "https://github.com/simrat39/symbols-outline.nvim"
  },
  tabular = {
    after_files = { "/home/justin/.local/share/nvim/site/pack/packer/opt/tabular/after/plugin/TabularMaps.vim" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/justin/.local/share/nvim/site/pack/packer/opt/tabular",
    url = "https://github.com/godlygeek/tabular"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n�\3\0\0\6\0\27\00016\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\n\0005\3\6\0005\4\4\0005\5\3\0=\5\5\4=\4\a\0035\4\b\0=\4\t\3=\3\v\0025\3\15\0005\4\r\0005\5\f\0=\5\14\4=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\3=\3\21\2B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\22\0'\2\23\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\22\0'\2\24\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\22\0'\2\25\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\22\0'\2\26\0B\0\2\1K\0\1\0\fneoclip\rprojects\rdotfiles\bfzf\19load_extension\fpickers\fbuffers\1\0\1\ntheme\bivy\14git_files\1\0\1\ntheme\bivy\15find_files\1\0\0\17find_command\1\0\1\ntheme\bivy\1\6\0\0\arg\f--files\r--hidden\a-g\n!.git\rdefaults\1\0\0\18layout_config\1\0\1\20prompt_position\btop\rmappings\1\0\0\6i\1\0\0\1\0\1\n<C-H>\14which_key\nsetup\14telescope\frequire\0" },
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["toggleterm.nvim"] = {
    config = { "\27LJ\2\n3\0\1\2\0\3\1\0056\1\0\0009\1\1\0019\1\2\1\24\1\0\1L\1\2\0\fcolumns\6o\bvim�̙�\6���\3s\1\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0003\3\3\0=\3\5\2B\0\2\1K\0\1\0\tsize\1\0\2\17open_mapping\n<C-T>\14direction\rvertical\0\nsetup\15toggleterm\frequire\0" },
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["tokyonight.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\27colorscheme tokyonight\bcmd\bvim\0" },
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["trouble.nvim"] = {
    commands = { "Trouble" },
    config = { "\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\ftrouble\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/justin/.local/share/nvim/site/pack/packer/opt/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["vim-illuminate"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/vim-illuminate",
    url = "https://github.com/RRethy/vim-illuminate"
  },
  ["vim-markdown"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/vim-markdown",
    url = "https://github.com/plasticboy/vim-markdown"
  },
  ["vim-matchup"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  },
  ["vim-projectionist"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/vim-projectionist",
    url = "https://github.com/tpope/vim-projectionist"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-scriptease"] = {
    commands = { "Messages" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/justin/.local/share/nvim/site/pack/packer/opt/vim-scriptease",
    url = "https://github.com/tpope/vim-scriptease"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14which-key\frequire\0" },
    loaded = true,
    path = "/home/justin/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^sqlite"] = "sqlite.lua"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: tokyonight.nvim
time([[Config for tokyonight.nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\27colorscheme tokyonight\bcmd\bvim\0", "config", "tokyonight.nvim")
time([[Config for tokyonight.nvim]], false)
-- Config for: project.nvim
time([[Config for project.nvim]], true)
try_loadstring("\27LJ\2\n>\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\17project_nvim\frequire\0", "config", "project.nvim")
time([[Config for project.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\n�\a\0\0\r\0014\0r6\0\0\0'\2\1\0B\0\2\0029\0\2\0006\2\3\0009\2\4\0029\2\5\0029\2\6\2B\2\1\0A\0\0\0026\1\0\0'\3\a\0B\1\2\0025\2\b\0-\3\0\0=\3\t\2=\0\n\0026\3\0\0'\5\v\0B\3\2\0029\3\f\0035\5\19\0005\6\18\0-\a\0\0>\a\1\0066\a\3\0009\a\r\a'\t\14\0\18\n\0\0005\v\16\0005\f\15\0=\f\17\vB\a\4\2=\a\n\6=\6\20\5B\3\2\0016\3\21\0009\5\17\0B\3\2\0019\3\22\0019\3\f\0036\5\0\0'\a\23\0B\5\2\0029\5\f\0055\a\27\0005\b\25\0005\t\24\0=\t\26\b=\b\28\a=\2\29\aB\5\2\0A\3\0\0019\3\30\0019\3\f\0035\5$\0005\6#\0005\a\"\0006\b\0\0'\n\31\0B\b\2\0029\b \b9\b!\bB\b\1\2=\b!\a=\a \6=\6%\5-\6\0\0=\6\t\5=\0\n\5B\3\2\0016\3&\0005\5'\0B\3\2\4X\6\4�8\b\a\0019\b\f\b\18\n\2\0B\b\2\1E\6\3\3R\6�6\3\0\0'\5(\0B\3\2\0029\4\f\0035\0062\0004\a\a\0009\b)\0039\b*\b9\b+\b>\b\1\a9\b)\0039\b,\b9\b-\b>\b\2\a9\b)\0039\b,\b9\b.\b>\b\3\a9\b)\0039\b,\b9\b/\b>\b\4\a9\b)\0039\b,\b9\b0\b>\b\5\a9\b)\0039\b,\b9\b1\b>\b\6\a=\a3\6B\4\2\1K\0\1\0\0�\fsources\1\0\1\14autostart\2\15shellcheck\rhadolint\tfish\fgitlint\vflake8\16diagnostics\rgitsigns\17code_actions\rbuiltins\fnull-ls\1\b\0\0\fpyright\rdockerls\nvimls\ncmake\vbashls\rmarksman\ntaplo\vipairs\rsettings\1\0\0\1\0\0\1\0\0\fschemas\tjson\16schemastore\vjsonls\rlsponfig\flibrary\1\0\0\fplugins\1\0\0\1\4\0\0\20nvim-treesitter\17plenary.nvim\19telescope.nvim\flua-dev\16sumneko_lua\nprint\vserver\1\0\0\1\0\0\19offsetEncoding\1\0\0\1\2\0\0\vutf-16\nforce\15tbl_extend\nsetup\22clangd_extensions\17capabilities\14on_attach\1\0\0\14lspconfig\29make_client_capabilities\rprotocol\blsp\bvim\24update_capabilities\17cmp_nvim_lsp\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: leap.nvim
time([[Config for leap.nvim]], true)
try_loadstring("\27LJ\2\n�\1\0\0\3\0\t\0\0146\0\0\0'\2\1\0B\0\2\0029\1\2\0B\1\1\0019\1\3\0009\1\4\1'\2\6\0=\2\5\0019\1\3\0009\1\4\1'\2\b\0=\2\a\1K\0\1\0\f<s-tab>\15prev_match\n<tab>\15next_match\17special_keys\topts\24set_default_keymaps\tleap\frequire\0", "config", "leap.nvim")
time([[Config for leap.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n�\5\0\0\6\0\29\0%6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0005\4\t\0=\4\n\3=\3\v\0025\3\f\0005\4\r\0=\4\14\3=\3\15\0025\3\19\0005\4\16\0005\5\17\0=\5\18\4=\4\20\0035\4\21\0005\5\22\0=\5\23\0045\5\24\0=\5\25\4=\4\26\3=\3\27\2B\0\2\0016\0\0\0'\2\28\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\23treesitter-context\16textobjects\tswap\18swap_previous\1\0\1\14<leader>S\21@parameter.inner\14swap_next\1\0\1\14<leader>s\21@parameter.inner\1\0\1\venable\2\vselect\1\0\0\fkeymaps\1\0\b\aac\17@class.outer\aic\17@class.inner\ail\16@loop.inner\aal\16@loop.outer\aaf\20@function.outer\aia\21@parameter.inner\aif\20@function.inner\aaa\21@parameter.outer\1\0\2\venable\2\14lookahead\2\17query_linter\16lint_events\1\3\0\0\rBufWrite\15CursorHold\1\0\2\venable\2\21use_virtual_text\2\fmatchup\25disable_virtual_text\1\2\0\0\vpython\1\0\1\venable\2\14highlight\1\0\1\venable\2\21ensure_installed\1\0\0\1\14\0\0\bcpp\6c\tbash\blua\vpython\tfish\ncmake\fcomment\njsonc\tyaml\15dockerfile\nquery\rmarkdown\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: nvim-neoclip.lua
time([[Config for nvim-neoclip.lua]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\fneoclip\frequire\0", "config", "nvim-neoclip.lua")
time([[Config for nvim-neoclip.lua]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n�\3\0\0\6\0\27\00016\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\n\0005\3\6\0005\4\4\0005\5\3\0=\5\5\4=\4\a\0035\4\b\0=\4\t\3=\3\v\0025\3\15\0005\4\r\0005\5\f\0=\5\14\4=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\3=\3\21\2B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\22\0'\2\23\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\22\0'\2\24\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\22\0'\2\25\0B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\22\0'\2\26\0B\0\2\1K\0\1\0\fneoclip\rprojects\rdotfiles\bfzf\19load_extension\fpickers\fbuffers\1\0\1\ntheme\bivy\14git_files\1\0\1\ntheme\bivy\15find_files\1\0\0\17find_command\1\0\1\ntheme\bivy\1\6\0\0\arg\f--files\r--hidden\a-g\n!.git\rdefaults\1\0\0\18layout_config\1\0\1\20prompt_position\btop\rmappings\1\0\0\6i\1\0\0\1\0\1\n<C-H>\14which_key\nsetup\14telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: lsp_signature.nvim
time([[Config for lsp_signature.nvim]], true)
try_loadstring("\27LJ\2\n`\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\20floating_window\1\16hint_enable\2\nsetup\18lsp_signature\frequire\0", "config", "lsp_signature.nvim")
time([[Config for lsp_signature.nvim]], false)
-- Config for: neogen
time([[Config for neogen]], true)
try_loadstring("\27LJ\2\n�\1\0\0\6\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\a\0005\4\5\0005\5\4\0=\5\6\4=\4\b\3=\3\t\2B\0\2\1K\0\1\0\14languages\vpython\1\0\0\rtemplate\1\0\0\1\0\1\26annotation_convention\22google_docstrings\1\0\1\19snippet_engine\fluasnip\nsetup\vneogen\frequire\0", "config", "neogen")
time([[Config for neogen]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n�\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\15extensions\1\5\0\0\rneo-tree\rfugitive\15toggleterm\16nvim-dap-ui\foptions\1\0\0\1\0\1\ntheme\15tokyonight\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: dressing.nvim
time([[Config for dressing.nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rdressing\frequire\0", "config", "dressing.nvim")
time([[Config for dressing.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\n@\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: dashboard-nvim
time([[Config for dashboard-nvim]], true)
try_loadstring("\27LJ\2\n�\r\0\0\a\0\19\0\0316\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\1'\3\4\0B\1\2\2'\2\6\0=\2\5\0005\2\b\0=\2\a\0004\2\a\0005\3\n\0>\3\1\0025\3\v\0>\3\2\0025\3\f\0>\3\3\0025\3\r\0>\3\4\0025\3\14\0>\3\5\0025\3\15\0'\4\16\0\18\5\1\0'\6\17\0&\4\6\4=\4\18\3>\3\6\2=\2\t\0K\0\1\0\vaction\r/.config\29Telescope dotfiles path=\1\0\3\ticon\n  \tdesc-Open Personal dotfiles                  \rshortcut\fSPC f d\1\0\4\ticon\n  \tdesc-Find  word                              \vaction\24Telescope live_grep\rshortcut\fSPC f w\1\0\4\ticon\n  \tdesc-File Browser                            \vaction\fNeotree\rshortcut\fSPC f b\1\0\4\ticon\n  \tdesc-Find  File                              \vaction\25Telescope find_files\rshortcut\fSPC f f\1\0\4\ticon\n  \tdesc-Recently opened files                   \vaction\23Telescope oldfiles\rshortcut\fSPC f h\1\0\4\ticon\n  \tdesc.Recently latest session                  \vaction\16SessionLoad\rshortcut\fSPC s l\18custom_center\1\a\0\0�\1 ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗�\1 ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║�\1 ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║�\1 ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║�\1 ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║�\1 ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝\18custom_header\14telescope\22default_executive\tHOME\vgetenv\aos\14dashboard\frequire\0", "config", "dashboard-nvim")
time([[Config for dashboard-nvim]], false)
-- Config for: neogit
time([[Config for neogit]], true)
try_loadstring("\27LJ\2\nz\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\17integrations\1\0\1\rdiffview\2\1\0\1 disable_commit_confirmation\2\nsetup\vneogit\frequire\0", "config", "neogit")
time([[Config for neogit]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
try_loadstring("\27LJ\2\n�\4\0\0\f\0\23\0<6\0\0\0'\2\1\0B\0\2\0029\1\2\0009\1\3\0015\3\4\0B\1\2\1'\1\5\0006\2\6\0009\2\a\0029\2\b\2\18\4\1\0B\2\2\2\15\0\2\0X\3\a�6\2\0\0'\4\t\0B\2\2\0029\2\n\0025\4\v\0=\1\f\4B\2\2\0016\2\0\0'\4\t\0B\2\2\0029\2\n\2B\2\1\0015\2\15\0006\3\6\0009\3\r\0036\5\0\0'\a\14\0B\5\2\0A\3\0\2=\3\16\0026\3\6\0009\3\r\0036\5\0\0'\a\17\0B\5\2\0A\3\0\2=\3\18\0026\3\6\0009\3\r\0036\5\0\0'\a\19\0B\5\2\0A\3\0\2=\3\20\0026\3\21\0\18\5\2\0B\3\2\4H\6\4�9\b\22\0\18\n\6\0\18\v\a\0B\b\3\1F\6\3\3R\6�K\0\1\0\17add_snippets\npairs\blua-me.modules.completion.snippets.lua_snips\rmarkdown,me.modules.completion.snippets.markdown\vpython\1\0\0*me.modules.completion.snippets.python\15tbl_values\npaths\1\0\0\14lazy_load luasnip.loaders.from_vscode\16isdirectory\afn\bvim\28~/.config/nvim/snippets\1\0\2\25store_selection_keys\n<C-S>\18update_events\29TextChanged,TextChangedI\15set_config\vconfig\fluasnip\frequire\0", "config", "LuaSnip")
time([[Config for LuaSnip]], false)
-- Config for: nvim-notify
time([[Config for nvim-notify]], true)
try_loadstring("\27LJ\2\n2\0\0\4\0\3\0\0066\0\0\0006\1\2\0'\3\1\0B\1\2\2=\1\1\0K\0\1\0\frequire\vnotify\bvim\0", "config", "nvim-notify")
time([[Config for nvim-notify]], false)
-- Config for: diffview.nvim
time([[Config for diffview.nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rdiffview\frequire\0", "config", "diffview.nvim")
time([[Config for diffview.nvim]], false)
-- Config for: bufferline.nvim
time([[Config for bufferline.nvim]], true)
try_loadstring("\27LJ\2\n�\1\0\0\6\0\t\0\0186\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\3\0004\4\3\0005\5\4\0>\5\1\4=\4\5\3=\3\a\2B\0\2\0016\0\0\0'\2\b\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nscope\foptions\1\0\0\foffsets\1\0\3\rfiletype\rneo-tree\ttext\18File Explorer\15text_align\vcenter\1\0\3\15close_icon\b\fnumbers\14buffer_id\20separator_style\nthick\nsetup\15bufferline\frequire\0", "config", "bufferline.nvim")
time([[Config for bufferline.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\n�\1\0\0\b\0\b\2!6\0\0\0006\2\1\0009\2\2\0029\2\3\2)\4\0\0B\2\2\0A\0\0\3\b\1\0\0X\2\20�6\2\1\0009\2\2\0029\2\4\2)\4\0\0\23\5\1\0\18\6\0\0+\a\2\0B\2\5\2:\2\1\2\18\4\2\0009\2\5\2\18\5\1\0\18\6\1\0B\2\4\2\18\4\2\0009\2\6\2'\5\a\0B\2\3\2\n\2\0\0X\2\2�+\2\1\0X\3\1�+\2\2\0L\2\2\0\a%s\nmatch\bsub\23nvim_buf_get_lines\24nvim_win_get_cursor\bapi\bvim\vunpack\0\2-\0\1\4\1\2\0\5-\1\0\0009\1\0\0019\3\1\0B\1\2\1K\0\1\0\1�\tbody\15lsp_expand�\2\0\1\3\4\a\0,-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4�-\1\0\0009\1\1\1B\1\1\1X\1\"�-\1\1\0\15\0\1\0X\2\t�-\1\1\0009\1\2\1B\1\1\2\15\0\1\0X\2\4�-\1\1\0009\1\3\1B\1\1\1X\1\22�-\1\2\0\15\0\1\0X\2\t�-\1\2\0009\1\4\1B\1\1\2\15\0\1\0X\2\4�-\1\2\0009\1\5\1B\1\1\1X\1\n�-\1\3\0B\1\1\2\15\0\1\0X\2\4�-\1\0\0009\1\6\1B\1\1\1X\1\2�\18\1\0\0B\1\1\1K\0\1\0\0�\1�\2�\3�\rcomplete\14jump_next\rjumpable\19expand_or_jump\23expand_or_jumpable\21select_next_item\fvisible�\1\0\1\4\3\5\0'-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4�-\1\0\0009\1\1\1B\1\1\1X\1\29�-\1\1\0\15\0\1\0X\2\v�-\1\1\0009\1\2\1)\3��B\1\2\2\15\0\1\0X\2\5�-\1\1\0009\1\3\1)\3��B\1\2\1X\1\15�-\1\2\0\15\0\1\0X\2\n�-\1\2\0009\1\2\1+\3\2\0B\1\2\2\15\0\1\0X\2\4�-\1\2\0009\1\4\1B\1\1\1X\1\2�\18\1\0\0B\1\1\1K\0\1\0\0�\1�\2�\14jump_prev\tjump\rjumpable\21select_prev_item\fvisible�\a\1\0\r\0005\0|6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0023\3\4\0009\4\5\0005\6\t\0005\a\a\0003\b\6\0=\b\b\a=\a\n\0065\a\14\0006\b\0\0'\n\v\0B\b\2\0029\b\f\b5\n\r\0B\b\2\2=\b\15\a=\a\16\0065\a\20\0009\b\17\0009\n\17\0009\n\18\n)\f��B\n\2\0025\v\19\0B\b\3\2=\b\21\a9\b\17\0009\n\17\0009\n\18\n)\f\4\0B\n\2\0025\v\22\0B\b\3\2=\b\23\a9\b\17\0009\b\24\bB\b\1\2=\b\25\a9\b\17\0009\b\24\bB\b\1\2=\b\26\a9\b\17\0003\n\27\0005\v\28\0B\b\3\2=\b\29\a9\b\17\0003\n\30\0005\v\31\0B\b\3\2=\b \a9\b\17\0009\b!\bB\b\1\2=\b\"\a9\b\17\0009\b\24\bB\b\1\2=\b#\a=\a\17\0069\a$\0009\a%\a4\t\6\0005\n&\0>\n\1\t5\n'\0>\n\2\t5\n(\0>\n\3\t5\n)\0>\n\4\t5\n*\0>\n\5\t4\n\3\0005\v+\0>\v\1\n5\v,\0>\v\2\nB\a\3\2=\a%\6B\4\2\0019\4\5\0009\4-\4'\6.\0005\a0\0009\b\17\0009\b/\b9\b-\bB\b\1\2=\b\17\a4\b\3\0005\t1\0>\t\1\b=\b%\aB\4\3\0019\4\5\0009\4-\4'\0062\0005\a3\0009\b\17\0009\b/\b9\b-\b4\n\0\0B\b\2\2=\b\17\a9\b$\0009\b%\b4\n\3\0005\v4\0>\v\1\nB\b\2\2=\b%\aB\4\3\0012\0\0�K\0\1\0\1\0\1\tname\fcmdline\1\0\0\6:\1\0\1\tname\vbuffer\1\0\0\vpreset\6/\fcmdline\1\0\1\tname\tpath\1\0\1\tname\vbuffer\1\0\1\tname\tfish\1\0\1\tname\rnvim_lua\1\0\1\tname\fdoxygen\1\0\1\tname\fluasnip\1\0\1\tname\rnvim_lsp\fsources\vconfig\n<C-c>\t<CR>\fconfirm\f<S-TAB>\1\3\0\0\6i\6s\0\n<Tab>\1\3\0\0\6i\6s\0\v<DOWN>\t<UP>\nabort\n<C-f>\1\3\0\0\6i\6c\n<C-b>\1\0\0\1\3\0\0\6i\6c\16scroll_docs\fmapping\15formatting\vformat\1\0\0\1\0\2\rmaxwidth\0032\14with_text\2\15cmp_format\flspkind\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\0\vneogen\fluasnip\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: mason.nvim
time([[Config for mason.nvim]], true)
try_loadstring("\27LJ\2\n�\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\aui\1\0\0\nicons\1\0\0\1\0\3\21server_installed\b✓\23server_uninstalled\b✗\19server_pending\b➜\nsetup\nmason\frequire\0", "config", "mason.nvim")
time([[Config for mason.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: toggleterm.nvim
time([[Config for toggleterm.nvim]], true)
try_loadstring("\27LJ\2\n3\0\1\2\0\3\1\0056\1\0\0009\1\1\0019\1\2\1\24\1\0\1L\1\2\0\fcolumns\6o\bvim�̙�\6���\3s\1\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0003\3\3\0=\3\5\2B\0\2\1K\0\1\0\tsize\1\0\2\17open_mapping\n<C-T>\14direction\rvertical\0\nsetup\15toggleterm\frequire\0", "config", "toggleterm.nvim")
time([[Config for toggleterm.nvim]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file NeoTreeFocusToggle lua require("packer.load")({'neo-tree.nvim'}, { cmd = "NeoTreeFocusToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SymbolsOutline lua require("packer.load")({'symbols-outline.nvim'}, { cmd = "SymbolsOutline", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Messages lua require("packer.load")({'vim-scriptease'}, { cmd = "Messages", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Neoformat lua require("packer.load")({'neoformat'}, { cmd = "Neoformat", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Trouble lua require("packer.load")({'trouble.nvim'}, { cmd = "Trouble", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DapUiToggle lua require("packer.load")({'nvim-dap-ui', 'nvim-dap'}, { cmd = "DapUiToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Lspsaga lua require("packer.load")({'lspsaga.nvim'}, { cmd = "Lspsaga", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Neotree lua require("packer.load")({'neo-tree.nvim'}, { cmd = "Neotree", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'tabular', 'glow.nvim'}, { ft = "markdown" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
