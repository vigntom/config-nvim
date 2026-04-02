" nocompatible: unnecessary in Neovim; shell + gui + t_AB/t_AF: lua/options.lua

""" coc recomendations settings
" hidden, backup, updatetime, shortmess, cmdheight, signcolumn: lua/options.lua

""" end coc

" termguicolors: lua/options.lua

" syntax, filetype, helptags, background, colorscheme, guifont: lua/options.lua (VimEnter)

" noerrorbells / visualbell / GUIEnter + js/ts syntax sync: lua/options.lua

" indent, search, display, undo, swap: lua/options.lua
" airline, seiya, tmuxline: lua/plugins/ui.lua (vim-airline init); indentLine/polyglot: lua/plugins/languages.lua; choosewin: lua/plugins/extras.lua
" ALE: lua/plugins/ale.lua; g:ale_disable_lsp / g:ale_completion_enabled: init.vim
" emmet-vim: lua/plugins/languages.lua; SuperTab: lua/plugins/extras.lua; delimitMate: lua/plugins/general.lua
" formatoptions (no autocomment): lua/options.lua
" filetype detect / tab settings / trim trailing ws: lua/autocmds.lua

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

" Plugin-tied / buffer maps (rest: lua/autocmds.lua)
au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
au FileType html,css,html.mustache,eruby,jst,html.handlebars,pug,javascript,javascriptreact,typescript,typescriptreact,vue,html.vue EmmetInstall
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
      \ { 'l': '~/.config/nvim/lua/config/lazy.lua' },
      \ { 'p': '~/.config/nvim/lua/plugins/init.lua' },
      \ { 'c': '~/.config/nvim/settings/config.vim' },
      \ { 'm': '~/.config/nvim/settings/mappings.vim' }
      \ ]
"
let g:startify_commands = [
      \ { 'r': [ 'Reload', 'source $MYVIMRC' ] },
      \ { 'u': [ 'Reload + Lazy sync', 'source $MYVIMRC | Lazy sync' ] },
      \ { 'U': [ 'Lazy sync', 'Lazy sync' ] },
      \ { 'g': [ 'Lazy UI', 'Lazy' ] },
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

" terraform LSP: coc-settings.json -> languageserver.terraform (+ hashivim/vim-terraform)
" (removed unused g:LanguageClient_serverCommands — LanguageClient-neovim not in use)

" lua <<EOF
"   require'lspconfig'.terraformls.setup{}
" EOF

" autocmd BufWritePre *.tfvars lua vim.lsp.buf.format()
" autocmd BufWritePre *.tf lua vim.lsp.buf.format()
