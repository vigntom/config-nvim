let config = [
      \'plugins', 
      \'settings/config', 
      \'settings/mappings', 
      \'settings/javascript'
      \]

let baseDir = "~/.config/nvim"

for src in config
  let fileName = baseDir . "/" . src . ".vim"
  
  if filereadable(expand(fileName))
    exec 'source ' . fileName
  endif
endfor

