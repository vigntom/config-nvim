set nocompatible
set shell=/bin/sh

if (has("termguicolors"))
  set termguicolors
endif

if (has("gui"))
  set guioptions-=m
  set guioptions-=T
  set guioptions-=r
endif

syntax on
syntax enable
filetype plugin indent on
silent! helptags ALL

set background=dark
" colorscheme Mustang
" colorscheme mango
" colorscheme tender
" colorscheme zenburn
" colorscheme OceanicNext
" colorscheme gruvbox
" colorscheme janah
colorscheme mustang

set guifont=Terminus\ 11

" Disable beep and flash
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

set autoindent
set backspace=2
set tabstop=4
set softtabstop=2
set shiftwidth=2
set clipboard=unnamedplus
set directory-=.               " don't store swapfiles in the current directory
set encoding=utf-8
set expandtab                  " expand tabs to spaces
set incsearch                  " search as you type 
set ignorecase                 " case-insensitive search
set smartcase                  " case-sensitive search if any caps
set smarttab
set completeopt=longest,menuone
" set list                       " show trailing whitespaces
set listchars=space:·,tab:▸\ ,trail:▫,extends:>,precedes:<,nbsp:+,eol:¬
set number                     " show line number"
set ruler
set mouse=a

" Enable persistent undo
set undofile
set undodir=~/.config/nvim/undo

set nowrap
set linebreak
set autoread

"
set backupcopy=yes

"let g:airline_theme = 'tender'
"let g:airline_theme='oceanicnext'
"let g:airline_theme='dark'
let g:seiya_target_groups = has('nvim') ? ['guibg'] : ['ctermbg']
let g:seiya_auto_enable=1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_powerline_fonts = 1
""let g:airline_symbols.space = "\ua0"

let g:tmuxline_preset = 'full'
let g:airline#extensions#tmuxline#enabled = 0
"
"let g:indentLine_setColors = 0
let g:indentLine_color_gui = "#3b3b3b"
let g:indentLine_char = '┆' 

let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_linters = {}
let g:ale_linters.javascript = ['standard']
let g:ale_linters.haskell = ['hlint']
let g:ale_fixers = {}
let g:ale_fixers.javascript = ['standard']
let g:ale_fix_on_save = 1
""let g:choosewin_overlay_enable = 1

let g:user_emmet_install_global = 0

if exists('g:plugs["tern_for_vim"]')
  let g:deoplete#omni#functions = {}
  let g:deoplete#omni#functions.javascript = [
        \ 'tern#Complete', 
        \ 'jspc#omni'
        \ ]
endif

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx']= ['file', 'ultisnips', 'ternjs']
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']
let g:tern_request_timeout = 1
let g:SuperTabClosePreviewOnPopupClose = 1
"
au FileType javascript let g:SuperTabDefaultCompletion = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<c-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

let delimitMate_expantd_cr = 1
"
" Disable automatic comment insertion
au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

""" File detect
au BufNewFile,BufRead *asterisk*/*.conf set filetype=asterisk
au BufNewFile,BufRead *Xresources.d/* set filetype=xdefaults
au BufNewFile,BufRead sed.* set filetype=sed
au! BufRead,BufNewFile .gemrc,.irbrc,.pryrc setf ruby
au BufNewFile,BufRead /etc/sudoers.d/* set filetype=sudoers
au BufNewFile,BufRead ~/.moe/config/Xresources.d/xsession.*/* set filetype=sh
au BufNewFile,BufRead xmonad.hs let g:hdevtools_options = '-g -i$HOME/.xmonad/lib'
au BufNewFile,BufRead named.conf set filetype=named
au BufNewFile,BufRead named.zone set filetype=bindzone
au BufNewFile,BufRead ~/.ghci set filetype=haskell
au BufNewFile,BufRead .babelrc set filetype=json
au BufNewFile,BufRead *.scss set filetype=scss.css
au BufNewFile,BufRead ~/.xmonad/* call s:add_xmonad_path()

au BufWritePost *.js silent !standard --fix %

au FileType ruby setlocal ts=2 sts=0 sw=2 expandtab
au FileType eruby setlocal ts=3 sts=0 sw=2 expandtab
au FileType html setlocal ts=2 sts=0 sw=2 expandtab
au FileType javascript setlocal ts=2 sts=0 sw=2 expandtab
au FileType css setlocal ts=2 sts=0 sw=2 expandtab
au FileType scss setlocal ts=2 sts=0 sw=2 expandtab
au FileType sass setlocal ts=2 sts=0 sw=2 expandtab
au FileType conf setlocal ts=4 sts=0 sw=4 noexpandtab
au FileType asterisk setlocal ts=4 sts=0 sw=4 expandtab
au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
au FileType gitcommit setlocal spell textwidth=72
au FileType html,css,html.mustache,eruby,jst EmmetInstall
au FileType javascript,css,scss,sass,haskell,html autocmd BufWritePre <buffer> %s/\s\+$//e
au FileType scss set iskeyword+=-
au FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>

" au FileType css,scss setlocal omnifunc=csscomplete#CompleteCSS

set tags+=gems.tags

function! s:add_xmonad_path()
  if !exists('b:ghcmod_ghc_options')
    let b:ghcmod_ghc_options = []
  endif
  call add(b:ghcmod_ghc_options, '-i' . expand('~/.xmonad/lib'))
endfunc

" Fix Cursor in TMUX
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Don't copy the contents of an overwritten selection.
vnoremap p "_dP

" marks 80th column
if (exists('+colorcolumn'))
    set colorcolumn=120
    highlight ColorColumn ctermbg=9
endif

" startify
    let g:startify_commands = [
        \ ['Reload', 'source $MYVIMRC'],
        \ ['Update', 'so $MYVIMRC | PlugUpgrade | so $MYVIMRC | PlugUpdate | so $MYVIMRC'],
        \ ['Update Plugins', 'PlugUpdate'],
        \ ['Upgrade Plug', 'PlugUpgrade'],
        \ ]

" quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" easymotion
let g:EasyMotion_do_mapping = 0


