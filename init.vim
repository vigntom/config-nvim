call plug#begin('~/.config/nvim/plugged')

" Colorthemes
Plug 'vim-scripts/Mustang2'
Plug 'vim-scripts/Zenburn'
Plug 'goatslacker/mango.vim'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'zanglg/nova.vim'

" Lookup
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"
Plug 'editorconfig/editorconfig-vim'
"
"
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
"Plug 'Yggdroot/indentLine'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer  --clang-completer --system-libclang' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ervandew/supertab'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 't9md/vim-choosewin'

""" Auto Pairs
" Plug 'jiangmiao/auto-pairs'
Plug 'Raimondi/delimitMate'

""" Surround.vim
" Examples start \"Hello World!\"
" cs\"' : -> 'Hello World!'
" cs'<q>: -> <q>Hello World!</q>
" cst\" : \"Hello World!\"
"
" ds":  -> Hello World!
"
" ysiw] (iw is a text object, cursor on Hello): -> [Hello] world!
" cs]{ (use } instead of { for no space): { Hello } World!
" yssb or yss: ({ Hello } World!)
"
" ds{ds): Hello World!
"
" ysiw<em>: -> <em>Hello</em> World!
"
" (visual mode) S<p class="important"> : 
" -> <p class="important">
"     <em>Hello</em> World!
"    </p>
"

""" Fuzzy finder
" my current config
" Leader z as leader
" f files
" b buffers
" l last files
Plug 'junegunn/fzf', { 'dir': '~/.config/nvim/plugsrc/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'lvht/fzf-mru'

" s{char}{char}
" S search backward 
" s or ; next match
" 3; to the third match
" Ctrl-o or '' go to starting point
Plug 'justinmk/vim-sneak'
Plug 'junegunn/vim-easy-align'
Plug 'mbbill/undotree'

""" nerdcommenter
" Leader cc : comment
" Leader cn : comment with nesting
" Leader c<space> : toggle
"
"Plug 'scrooloose/nerdcommenter'
"
" gcc
Plug 'tpope/vim-commentary'

""" git
Plug 'tpope/vim-fugitive'

""" Linter
Plug 'w0rp/ale'
"Plug 'benekastah/neomake'

""" Tagbar
Plug 'majutsushi/tagbar'

""" Color preview
" Plug 'Chrisbra/Colorizer', { 'on': 'ColorToggle' }
Plug 'lilydjwg/colorizer', { 'on': 'ColorToggle' }


""" JavaScript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'elzr/vim-json'
Plug 'othree/yajs.vim'
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }

""" HTML css
" Leader : <c-y>
" Expand abbreviation : ,
" Expand word : ;
" Update tag : u  
" Wrap with: (visual mode) , 
" Balance tag: d
" Balance tag outward: D
"
Plug 'othree/html5.vim'
Plug 'mattn/emmet-vim'
Plug 'JulesWang/css.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'othree/csscomplete.vim'

"Haskell
Plug 'bitc/vim-hdevtools'
Plug 'eagletmt/ghcmod-vim'

"Hex files
Plug 'fidian/hexmode'

" Utils
Plug 'edkolev/tmuxline.vim'

call plug#end()

""" Configuration
"""
"for vim-7
set t_Co=256

"for neovim 0.1.3 and 0.1.4
"let $NVIM_TUI_ENABLE_TRUE_COLOR=1

"neovim >= 0.1.5 or vim 8
if (has("termguicolors"))
  set termguicolors
endif

set guifont=Terminus\ 11

syntax enable
set background=dark
colorscheme Mustang
" colorscheme mango
"colorscheme tender

"""
" colorscheme solarized
" let g:solarized_termcolor=256
" colorscheme zenburn
" colorscheme OceanicNext
" colorscheme gruvbox

let mapleader = "\<SPACE>"

"let g:airline_theme = 'tender'
"let g:airline_theme='oceanicnext'
"let g:airline_theme='dark'

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

"""
" let g:javascript_plugin_flow=1

"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_linters = {
      \'javascript': ['prettier', 'standard'],
      \'haskell': ['hlint']
      \}
"let g:ale_linters.javascript = ['eslint']
"let g:ale_linters.haskell = ['hlint']
"autocmd! BufWritePost * Neomake

let g:neomake_place_signs = 0
let g:neomake_open_list = 2
let g:neomake_javascript_enabled_makers = ['eslint']

""let g:choosewin_overlay_enable = 1

let g:user_emmet_install_global = 0
"
" tern
if exists('g:plugs["tern_for_vim"]')
  let g:deoplet#omni#functions = {}
  let g:deoplet#omni#functions.javascript = [
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
silent! helptags ALL

filetype plugin on

set clipboard=unnamedplus
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set nonumber
set ignorecase
set smartcase
set smarttab
set autoindent
set completeopt=longest,menuone
"set completeopt-=preview


" Disable beep and flash
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

filetype plugin indent on

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
au FileType html,css EmmetInstall
au FileType javascript,css,scss,sass,haskell,html autocmd BufWritePre <buffer> %s/\s\+$//e
au FileType scss set iskeyword+=-
au FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>

" au FileType css,scss setlocal omnifunc=csscomplete#CompleteCSS

set tags+=gems.tags

function! RelativeNumberToggle()
  if(&relativenumber == 1)
    set nornu
  else
    set rnu
  endif
endfunc

function! NumberToggle()
  if(&number == 1)
    set nonu
  else
    set nu
  endif
endfunc

function! s:add_xmonad_path()
  if !exists('b:ghcmod_ghc_options')
    let b:ghcmod_ghc_options = []
  endif
  call add(b:ghcmod_ghc_options, '-i' . expand('~/.xmonad/lib'))
endfunc

" Mapping general

" Mapping Insert mode
imap jk <Esc>
imap <C-Space> <C-X><C-O>

nmap <Leader>tt :TagbarToggle<CR>
nmap - <Plug>(choosewin)

nnoremap <Leader>rr :call RelativeNumberToggle()<cr>
nnoremap <Leader>rn :call NumberToggle()<cr>

nnoremap <Leader>zf :Files<CR>
nnoremap <Leader>zb :Buffers<CR>
nnoremap <Leader>zl :FZFMru<CR>

if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

nnoremap <Leader>p pV`]=`]a<CR><Esc>

nnoremap <F5> :source $HOME/.config/nvim/init.vim<CR>
nnoremap <F6> :NERDTreeToggle<CR>
nnoremap <F7> :UndotreeToggle<CR>
nnoremap <F8> :TagbarToggle<CR>
nnoremap <F9> gg=G

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

nmap <Leader>tc :ColorToggle<CR>

"start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

"start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

