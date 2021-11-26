call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'doums/darcula'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'sheerun/vim-polyglot'
Plug 'romgrk/barbar.nvim'
Plug 'joshdick/onedark.vim'
Plug 'voldikss/vim-floaterm'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-commentary'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'famiu/feline.nvim'
call plug#end()

let mapleader=" "
"split navigations
nnoremap <C-J> <C-W><C-J> " Move below
nnoremap <C-K> <C-W><C-K> " Move above
nnoremap <C-L> <C-W><C-L> " Move right
nnoremap <C-H> <C-W><C-H> " Move left

nnoremap <silent> <A-k> :m--<CR>
nnoremap <silent> <A-j> :m+<CR>
nnoremap <C-Z> u

inoremap <C-Z> <C-O>

nnoremap <silent> <C-e> :lua require'tree'.toggle()<CR>
nnoremap <silent> <leader>r :NvimTreeRefresh<CR> 

set encoding=utf-8
set nu
set tabstop=2 expandtab smarttab shiftwidth=2 softtabstop=2 autoindent
set sessionoptions+=options,resize,winpos,terminal

let NERDTreeIgnore=['\.pyc$', '\~$']
let g:nvim_tree_ignore = ['.git', '.\pyc$']
colorscheme onedark
set termguicolors

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

nnoremap <silent> <C-P> :GFiles<CR>
nnoremap <silent> <leader>sf :Rg<CR>
nnoremap <silent> <C-F> :BLines<CR>
nnoremap <silent> <leader>sb :Buffers<CR>

" COC config

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references>
nmap <silent> gt <Plug>(coc-type-defintion)
inoremap <silent><expr> <c-space> coc#refresh()
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>ff  <Plug>(coc-format-selected)
nmap <leader>ff  <Plug>(coc-format)
" refactoring
nmap <leader>rf <Plug>(coc-refactor)

imap <C-BS> <C-W>
:set backspace=indent,eol,start


:tnoremap <C-T> <C-\><C-n> " exit terminal mode with ctrl-T


set noshowmode



nnoremap <silent> <A-,> :BufferPrev<CR>
nnoremap <silent> <A-.> :BufferNext<CR>
nnoremap <silent> <A-<> :BufferMovePrevious<CR>
nnoremap <silent> <A->> :BufferMoveNext<CR>
nnoremap <silent> <A-c> :BufferClose<CR>

lua << EOF
require('feline').setup()
EOF

highlight LuaTreeFolderIcon guibg=blue

let g:lua_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 0,
    \ 'files': 0,
    \}
autocmd FileType python let b:coc_root_patterns = ['.git', '.env', 'venv', '.venv', 'setup.cfg', 'setup.py', 'pyproject.toml', 'pyrightconfig.json']
let g:doge_doc_standard_python = 'google'

let g:floaterm_wintype = 'vsplit'
nnoremap <silent> <C-T> :FloatermToggle<CR>
let g:fzf_layout = { 'down': '~30%' }

let g:vim_markdown_folding_disabled = 1

let g:vim_markdown_conceal = 0
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
let g:vim_markdown_json_frontmatter = 1  " for JSON format
