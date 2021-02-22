let config = [
      \'plugins', 
      \'settings/commands',
      \'settings/config', 
      \'settings/mappings' 
      \]

let baseDir = "~/.config/nvim"

let g:ale_completion_enabled = 0
let g:ale_disable_lsp = 1

for src in config
  let fileName = baseDir . "/" . src . ".vim"
  
  if filereadable(expand(fileName))
    exec 'source ' . fileName
  endif
endfor

