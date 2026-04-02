" Legacy settings — most logic moved to Lua (see comments below).
" Keymaps: lua/keymaps.lua (editor / integrations / coc; settings/mappings.vim — stub)
"
" Options / UX: lua/options.lua
" Autocmds (filetype, trim, ruby setf, …): lua/autocmds.lua
" Lazy + plugin g:: lua/plugins/*.lua (airline/startify ui.lua; ALE ale.lua;
"   coc/emmet/vue/sneak/… languages.lua; asyncrun general.lua; …)
" g:ale_disable_lsp / g:ale_completion_enabled: init.lua
"
" Terraform LSP: coc-settings.json (languageserver.terraform) +
"   hashivim/vim-terraform
