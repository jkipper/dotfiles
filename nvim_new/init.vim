
let g:lua_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 0,
    \ 'files': 0
    \}
lua << EOF
require'plugins'
EOF

let mapleader=" "
set mouse=nv
" navigation
nnoremap <C-J> <C-W><C-J> " Move below
nnoremap <C-K> <C-W><C-K> " Move above
nnoremap <C-L> <C-W><C-L> " Move right
nnoremap <C-H> <C-W><C-H> " Move left

nnoremap <silent> <A-k> :m--<CR>
nnoremap <silent> <A-j> :m+<CR>

tnoremap <C-T> <C-\><C-n> " exit terminal mode with ctrl-T


set encoding=utf-8
set nu
set tabstop=2 expandtab smarttab shiftwidth=2 softtabstop=2 autoindent
set sessionoptions+=options,resize,winpos,terminal
set termguicolors
set backspace=indent,eol,start
set noshowmode
colorscheme onedark


" FZF
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

let g:fzf_layout = { 'down': '~30%' }

nnoremap <silent> <C-P> :GFiles<CR>
nnoremap <silent> <leader>sf :Rg<CR>
nnoremap <silent> <C-F> :BLines<CR>
nnoremap <silent> <leader>sb :Buffers<CR>

"NvimTree

nnoremap <silent> <C-e> :NvimTreeToggle<CR>
nnoremap <silent> <leader>r :NvimTreeRefresh<CR> 

" FLOATERM
let g:floaterm_wintype = 'vsplit'
nnoremap <silent> <C-T> :FloatermToggle<CR>

" Markdown

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
