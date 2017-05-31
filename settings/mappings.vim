let mapleader = "\<SPACE>"

"
au FileType javascript let g:SuperTabDefaultCompletion = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<c-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

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
" vmap <Enter> <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

"start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

cnoremap w!! %!sudo tee > /dev/null %

