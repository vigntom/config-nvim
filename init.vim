let config = [
      \'plugins', 
      \'settings/commands',
      \'settings/config', 
      \'settings/mappings' 
      \]

let baseDir = "~/.config/nvim"

for src in config
  let fileName = baseDir . "/" . src . ".vim"
  
  if filereadable(expand(fileName))
    exec 'source ' . fileName
  endif
endfor

