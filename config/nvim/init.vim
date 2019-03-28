if &compatible
 set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein')
  let s:toml = '~/.config/nvim/plugins.toml'
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif


filetype plugin indent on
syntax enable
set imdisable
set backspace=indent,eol,start
set nonumber

nnoremap wh <C-w>h
nnoremap wj <C-w>j
nnoremap wk <C-w>k
nnoremap wl <C-w>l

nnoremap wH <C-w>H
nnoremap wJ <C-w>J
nnoremap wK <C-w>K
nnoremap wL <C-w>L

nnoremap <silent> tg :<C-u>Denite
      \ -path=`substitute(finddir('.git', './;'), '.git', '', 'g')`
      \ file_rec<CR>
nnoremap <silent> tu :<C-u>Denite file_mru<CR>
nnoremap <silent> tf :<C-u>DeniteBufferDir file<CR>
nnoremap <silent> tb :<C-u>Denite buffer<CR>
call denite#custom#map('insert', "<C-n>", '<denite:move_to_next_line>')
call denite#custom#map('insert', "<C-p>", '<denite:move_to_previous_line>')

call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'default_opts', ['--follow', '--no-group', '--no-color'])

let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_camel_case = 0
let g:deoplete#enable_ignore_case = 0
let g:deoplete#enable_refresh_always = 0
let g:deoplete#enable_smart_case = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#max_list = 10000
inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<tab>"

let g:lightline = {
        \ 'colorscheme': 'solarized',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
        \   'right': [ [ 'lineinfo' ],
        \              [ 'asyncrun', 'fileencoding', 'filetype' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'LightlineModified',
        \   'readonly': 'LightlineReadonly',
        \   'fugitive': 'LightlineFugitive',
        \   'filename': 'LightlineFilename',
        \   'relativepath': 'LightLineRelativePath',
        \   'fileformat': 'LightlineFileformat',
        \   'filetype': 'LightlineFiletype',
        \   'fileencoding': 'LightlineFileencoding',
        \   'mode': 'LightlineMode',
        \   'asyncrun': 'AsyncRunStatus'
        \ }
        \ }

function! LightLineRelativePath()
  return expand('%')
endfunction

function! AsyncRunStatus()
  return g:asyncrun_status
endfunction

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%') ? expand('%') : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
    return fugitive#head()
  else
    return ''
  endif
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

set background=dark
"colorscheme monokai
"colorscheme molokai
"let g:molokai_original = 1
"let g:rehash256 = 1
colorscheme solarized
let g:solarized_termcolors=16
let g:solarized_termtrans=1
let g:solarized_degrade=0
let g:solarized_bold=0
let g:solarized_underline=1
let g:solarized_italic=1
let g:solarized_contrast='normal'
let g:solarized_visibility='normal'

" Plugin key-mappings.
let g:acp_enableAtStartup = 0
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-k> <Plug>(ale_previous_wrap)

"filetype
autocmd BufRead,BufNewFile *.slim set filetype=slim
autocmd BufRead,BufNewFile *.coffee set filetype=coffee
autocmd BufRead,BufNewFile *.{html,htm,vue*} set filetype=html
autocmd BufRead,BufNewFile *.m set filetype=octave
autocmd BufRead,BufNewFile *.oct set filetype=octave
autocmd BufRead,BufNewFile *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
autocmd BufRead,BufNewFile *.jsx set filetype=javascript.jsx
autocmd FileType coffee    setlocal sw=2 sts=2 ts=2 et
autocmd BufRead,BufNewFile *.plpgsql set filetype=pgsql

"template
autocmd BufNewFile *.tex 0r $HOME/.vim/template/tex.tex

"autocmd
"autocmd BufWritePost *.tex !latexmk "%:p"
"au BufWritePost * silent! execute "!latexmk %:p >/dev/null 2>&1" | redraw!
autocmd BufWritePost *.tex AsyncRun latexmk "%:p"

"autocmd BufWritePost *.js execute "!eslint %:p --fix" | edit!

"omnicompletion
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

"NeoFormat
let g:neoformat_enabled_javascript = ['eslint']
let g:neoformat_javascript_eslint = {
      \ 'exe': 'eslint',
      \ 'args': ['--stdin', '--fix'],
      \ 'stdin': 1,
      \ }
"augroup fmt
"  autocmd!
"  autocmd BufWritePre * undojoin | Neoformat
"augroup END


"Ale
let g:ale_echo_msg_format = '[%linter%] %s'
let g:ale_linters = {'javascript': ['eslint', 'flow']}

let g:ale_fixers = {'javascript': ['eslint']}
let g:ale_javascript_eslint_use_global = 0
let g:ale_fix_on_save = 1

"QuickFix
let g:quickrun_config = {
\   "_" : {
\       "outputter/buffer/close_on_empty" : 1
\   },
\}

set laststatus=2
set tabstop=2
set expandtab
set shiftwidth=2

inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

set foldmethod=indent
set foldlevel=1
set foldcolumn=0
".swp dir
set directory=~/.vim/tmp
