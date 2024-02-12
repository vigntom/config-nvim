set nocompatible
set shell=zsh

""" coc recomendations settings
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

""" end coc  

if (has("termguicolors"))
  set termguicolors
endif

if (has("gui"))
  set guioptions-=m
  set guioptions-=T
  set guioptions-=r
endif

" if !empty($CONEMUBUILD) 
  " set term=xterm 
  " set t_Co=256 
  let &t_AB="\e[48;5;%dm" 
  let &t_AF="\e[38;5;%dm" 
" endif 

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
" colorscheme base16-tomorrow-night

set guifont="Terminess Powerline:h12"
set guicursor=
" set guifont=Glass\ TTY\ VT220\ 12

" Disable beep and flash
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
  autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
  autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
endif

set autoindent
set backspace=2
set tabstop=4
set softtabstop=2
set shiftwidth=2
set clipboard=unnamedplus
" set directory-=.               " don't store swapfiles in the current directory
set encoding=utf-8
set expandtab                  " expand tabs to spaces
set incsearch                  " search as you type
set ignorecase                 " case-insensitive search
set smartcase                  " case-sensitive search if any caps
set smarttab
" set completeopt=longest,menuone
" set completeopt+=noselect,menuone
set completeopt-=preview
" set list                       " show trailing whitespaces
set listchars=space:·,tab:▸\ ,trail:▫,extends:>,precedes:<,nbsp:+,eol:¬
set relativenumber                     " show line number"
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
"
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
let g:airline#extensions#tmuxline#enabled = 1
let g:airline#estensions#ale#enabled = 1
"
"let g:indentLine_setColors = 0
let g:indentLine_color_gui = "#3b3b3b"
let g:indentLine_char = '┆'
"
let g:polyglot_disabled = ['javascript', 'javascript.jsx', 'javascriptreact', 'typescript']
let g:ale_lint_on_save = 1
" let g:ale_typescript_standard_executable = 'ts-standard'
let g:ale_lint_on_text_changed = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_linter_aliases = {}
let g:ale_linter_aliases.jsx = ['css', 'javascript']
let g:ale_linter_aliases.vue = ['javascript', 'vue']
let g:ale_linters = {}
let g:ale_linters.javascript = ['tsserver', 'eslint']
let g:ale_linters.javascriptreact = ['tsserver', 'eslint']
let g:ale_linters.typescript = ['tsserver', 'eslint', 'standard']
let g:ale_linters.typescriptreact = ['tsserver', 'eslint', 'standard']
let g:ale_linters.vue = ['tsserver', 'eslint', 'vls']
let g:ale_linters.haskell = ['hlint', 'hdevtools', 'ghc_mod']
let g:ale_linters.cpp = ['clang', 'clang-check']
let g:ale_linters.python = ['flake8']
let g:ale_linters.html = ['tsserver', 'htmlhint', 'stylelint']
let g:ale_linters.css = ['tsserver', 'stylelint']
let g:ale_linters.scss = ['tsserver', 'stylelint']

let g:ale_fixers = {
      \ 'javascript': ['prettier', 'eslint'],
      \ 'javascript.jsx': ['prettier', 'eslint'],
      \ 'javascriptreact': ['prettier', 'eslint'],
      \ 'typescript': ['prettier', 'eslint'],
      \ 'typescriptreact': ['prettier', 'eslint'],
      \ 'json': ['prettier'],
      \ 'yaml': ['prettier'],
      \ 'css': ['prettier', 'stylelint'],
      \ 'scss': ['prettier', 'stylelint']
      \ }

let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 0

let g:airline#extensions#ale#enbaled = 1
let g:choosewin_overlay_enable = 1

""" disable ale virtualtext
let g:ale_virtualtext_cursor = 'disabled'

""" User neovim diagnostics
let g:ale_use_neovim_diagnostics_api = 1

let g:user_emmet_install_global = 0
let g:user_emmet_settings = {
      \  'jsx': {
      \    'attribute_name': {'for': 'htmlFor', 'class': 'className', 'quote_char': "''"}
      \  },
      \   'javascriptreact': {
      \     'extends': 'jsx'
      \   },
      \   'javascript': {
      \     'extends': 'jsx'
      \   },
      \   'typescript': {
      \     'extends': 'jsx'
      \   },
      \   'typescriptreact': {
      \     'extends': 'jsx'
      \   }
      \}

" if exists('g:plugs["tern_for_vim"]')
"   let g:tern_show_argument_hints = 'on_hold'
"   let g:tern_show_signature_in_pum = 1

"   au FileType javascript setlocal omnifunc=tern#Complete
"   au FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>
" endif

" deoplete
" let g:deoplete#enable_at_startup = 1
" if !exists('g:deoplete#omni#input_patterns')
"   let g:deoplete#omni#input_patterns = {}
" endif
" let g:deoplete#sources#ternjs#filetypes = [
"                 \ 'jsx',
"                 \ 'javascript',
"                 \ 'javascript.jsx',
"                 \ 'vue',
"                 \ '...'
"                 \ ]

" au InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

let g:SuperTabDefaultCompletionType = "<c-n>"

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
au BufNewFile,BufRead .eslintrc set filetype=json
au BufNewFile,BufRead .haskyrc set filetype=json
au BufNewFile,BufRead .lintstagerc set filetype=json
au BufNewFile,BufRead .prettierrc set filetype=json
au BufNewFile,BufRead *.scss set filetype=scss.css
au BufNewFile,BufRead ~/.xmonad/* call s:add_xmonad_path()
au BufNewFile,BufRead *nginx/*.template set filetype=nginx 
au BufNewFile,BufRead *.graphql setfiletype graphql 
au BufNewFile,BufRead *.tf setfiletype terraform

au FileType ruby setlocal ts=2 sts=0 sw=2 expandtab
au FileType eruby setlocal ts=3 sts=0 sw=2 expandtab
au FileType html setlocal ts=2 sts=0 sw=2 expandtab
au FileType javascript setlocal ts=2 sts=0 sw=2 expandtab
au FileType vue setlocal ts=4 sts=0 sw=4 noexpandtab
au FileType css setlocal ts=2 sts=0 sw=2 expandtab
au FileType scss setlocal ts=2 sts=0 sw=2 expandtab
au FileType sass setlocal ts=2 sts=0 sw=2 expandtab
au FileType conf setlocal ts=4 sts=0 sw=4 noexpandtab
au FileType asterisk setlocal ts=4 sts=0 sw=4 expandtab
au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
au FileType php setlocal ts=4 sts=0 sw=4 expandtab
au FileType gitcommit setlocal spell textwidth=72
au FileType html,css,html.mustache,eruby,jst,html.handlebars,pug,javascript,javascriptreact,typescript,typescriptreact,vue EmmetInstall
au FileType javascript,css,scss,sass,haskell,html au BufWritePre <buffer> %s/\s\+$//e
au FileType scss set iskeyword+=-
" au FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>
au FileType lua setlocal noexpandtab

au BufWritePost javascript AsyncRun -post=checktime ./node_modules/.bin/standard --fix %

" omnifunc
" augroup omnifuncs
"   autocmd!
"   autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"   autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"   autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"   autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"   autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" augroup end

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
let g:startify_bookmarks = [
      \ { 'i': '~/.config/nvim/init.vim' },
      \ { 'p': '~/.config/nvim/plugins.vim' },
      \ { 'c': '~/.config/nvim/settings/config.vim' },
      \ { 'm': '~/.config/nvim/settings/mappings.vim' }
      \ ]
"
let g:startify_commands = [
      \ { 'r': [ 'Reload', 'source $MYVIMRC' ] },
      \ { 'u': [ 'Update', 'so $MYVIMRC | PlugUpgrade | so $MYVIMRC | PlugUpdate | so $MYVIMRC'] },
      \ { 'U': [ 'Update Plugins', 'PlugUpdate' ] },
      \ { 'g': [ 'Upgrade Plug', 'PlugUpgrade' ] },
      \ { ';': [ 'Restart Startify', 'Startify' ] },
      \ ]

" quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" easymotion
" let g:EasyMotion_do_mapping = 0
let g:sneak#label = 1
let g:vue_disable_pre_processors = 1
let g:loaded_matchit = 1

let g:rainbow_active = 1

let g:coc_global_extensions = [
  \ 'coc-json',
  \ 'coc-tsserver',
  \ ]

set directory=/var/tmp

let g:LanguageClient_serverCommands = {
      \ 'terraform': ['terraform-ls', 'serve'],
      \ }
