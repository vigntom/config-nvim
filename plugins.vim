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

