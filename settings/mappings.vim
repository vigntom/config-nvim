let mapleader = "\<SPACE>"
"
" au FileType javascript let g:SuperTabDefaultCompletion = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" let g:UltiSnipsExpandTrigger="<c-j>"
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

nnoremap <Leader>p pV`]=`]a<Esc>

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

" nmap g:EasyMotion_smartcase = 1
" nmap s <Plug>(easymotion-overwin-f2)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Remap macro recording from q to <Leader>q
nnoremap <Leader>q q
nnoremap q <Nop>

nnoremap <Leader>ht :GhcModType<cr>
nnoremap <Leader>htc :GhcModTypeClear<cr>
au FileType haskell nnoremap <buffer> <leader>? :call ale#cursor#ShowCursorDetail()<cr>

function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction

