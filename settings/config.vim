" nocompatible: unnecessary in Neovim; shell + gui + t_AB/t_AF: lua/options.lua

""" coc recomendations settings
" hidden, backup, updatetime, shortmess, cmdheight, signcolumn: lua/options.lua

""" end coc

" termguicolors: lua/options.lua

" syntax, filetype, helptags, background, colorscheme, guifont: lua/options.lua (VimEnter)

" noerrorbells / visualbell / GUIEnter + js/ts syntax sync: lua/options.lua

" indent, search, display, undo, swap: lua/options.lua
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
let g:airline#extensions#ale#enabled = 1
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
      \ 'lua': ['stylua'],
      \ 'json': ['prettier'],
      \ 'yaml': ['prettier'],
      \ 'css': ['prettier', 'stylelint'],
      \ 'scss': ['prettier', 'stylelint'],
      \ 'sh': ['shfmt']
      \ }

let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1

let g:airline#extensions#ale#enabled = 1
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
      \   },
      \   'vue-html': {
      \     'extends': 'html'
      \   },
      \   'vue': {
      \     'extends': 'html'
      \   },
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

let delimitMate_expanded_cr = 1
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
au BufNewFile,BufRead *nginx/*.inc set filetype=nginx 
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
au FileType yaml setlocal textwidth=120 tw=120
au FileType html,css,html.mustache,eruby,jst,html.handlebars,pug,javascript,javascriptreact,typescript,typescriptreact,vue,html.vue EmmetInstall
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

" marks 120th column
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
  \ 'coc-tsserver-dev',           
  \ 'coc-go',
  \ 'coc-graphql',
  \ 'coc-highlight',
  \ 'coc-html',
  \ 'coc-htmlhint',
  \ 'coc-html-css-support',
  \ '@yaegassy/coc-laravel',
  \ 'coc-lists',
  \ 'coc-lua',
  \ 'coc-markdownlint',
  \ 'coc-webview',
  \ 'coc-prisma',
  \ 'coc-stylelint',
  \ 'coc-sql',
  \ 'coc-svg',
  \ 'coc-swagger',
  \ 'coc-xml',
  \ 'coc-yaml',
  \ 'coc-yank',
  \ 'coc-markdown-preview-enhanced',
  \ 'coc-blade',
  \ 'coc-fzf-preview',
  \ 'coc-cssmodules',
  \ 'coc-docker',
  \ 'coc-css',
  \ 'coc-class-css',
  \ 'coc-copilot',
  \ 'coc-emmet',
  \ '@yaegassy/coc-nginx',
  \ '@yaegassy/coc-tailwindcss3',
  \ '@yaegassy/coc-volar',
  \ ]

" directory (swap): lua/options.lua

" terraform
let g:LanguageClient_serverCommands = {
    \ 'terraform': ['terraform-ls', 'serve'],
    \ }

" lua <<EOF
"   require'lspconfig'.terraformls.setup{}
" EOF

" autocmd BufWritePre *.tfvars lua vim.lsp.buf.format()
" autocmd BufWritePre *.tf lua vim.lsp.buf.format()
