call plug#begin('~/.config/nvim/plugged')

" Colorthemes
Plug 'croaker/mustang-vim'
Plug 'mhinz/vim-janah'
" Plug 'vim-scripts/Zenburn'
" Plug 'goatslacker/mango.vim'
" Plug 'rafi/awesome-vim-colorschemes'
" Plug 'zanglg/nova.vim'

" Lookup
Plug 'miyakogi/seiya.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'
"
Plug 'editorconfig/editorconfig-vim'
"
"
Plug 'scrooloose/nerdtree'
"
Plug 'chrisbra/NrrwRgn'
"
" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer  --clang-completer --system-libclang' }
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
"
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


"
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
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/committia.vim'

""" Linter
Plug 'w0rp/ale'

""" Tagbar
Plug 'majutsushi/tagbar'

""" Color preview
" Plug 'Chrisbra/Colorizer', { 'on': 'ColorToggle' }
Plug 'lilydjwg/colorizer', { 'on': 'ColorToggle' }

""" Ruby
Plug 'vim-ruby/vim-ruby'

""" JavaScript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'elzr/vim-json'
Plug 'othree/yajs.vim'
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mustache/vim-mustache-handlebars'
Plug 'briancollins/vim-jst'

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

""" Haskell
Plug 'bitc/vim-hdevtools'
Plug 'eagletmt/ghcmod-vim'

""" Hex files
Plug 'fidian/hexmode'

""" Utils
Plug 'edkolev/tmuxline.vim'

""" Experiment with
"
" s{char}{char}
" S search backward 
" s or ; next match
" 3; to the third match
" Ctrl-o or '' go to starting point
" Plug 'justinmk/vim-sneak'

"
" highlight charackters to target for f, F, t, T
Plug 'unblevable/quick-scope'
Plug 'easymotion/vim-easymotion'

"""
"""
call plug#end()

