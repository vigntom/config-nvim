-- Migrated from plugins.vim (vim-plug) — keep single list for bootstrap; split later.
-- stylua: ignore start
return {
  { "croaker/mustang-vim" },
  { "mhinz/vim-janah" },
  { "noahfrederick/vim-noctu" },
  { "chriskempson/base16-vim" },
  { "vim-scripts/Zenburn" },
  { "goatslacker/mango.vim" },
  { "rafi/awesome-vim-colorschemes" },
  { "zanglg/nova.vim" },

  { "vim-airline/vim-airline" },
  { "vim-airline/vim-airline-themes" },
  { "mhinz/vim-startify" },
  { "vim-scripts/BufOnly.vim" },
  { "editorconfig/editorconfig-vim" },
  { "chrisbra/NrrwRgn" },
  { "christoomey/vim-titlecase" },

  { "Raimondi/delimitMate" },
  { "isobit/vim-caddyfile" },

  {
    "junegunn/fzf",
    dir = vim.fn.expand("~/.config/nvim/plugsrc/fzf"),
    build = "./install --all",
  },
  { "junegunn/fzf.vim" },
  { "lvht/fzf-mru" },
  { "junegunn/vim-easy-align" },
  { "mbbill/undotree" },

  { "tpope/vim-commentary" },
  { "tpope/vim-fugitive" },
  { "rhysd/committia.vim" },
  { "airblade/vim-gitgutter" },

  { "w0rp/ale" },
  { "skywind3000/asyncrun.vim" },
  { "majutsushi/tagbar" },
  { "Chrisbra/Colorizer", cmd = "ColorToggle" },

  { "pangloss/vim-javascript" },
  { "yuezk/vim-js" },
  { "maxmellon/vim-jsx-pretty" },
  { "elzr/vim-json" },
  { "othree/yajs.vim" },
  { "othree/jspc.vim" },
  { "mustache/vim-mustache-handlebars" },
  { "ruanyl/vim-sort-imports" },
  { "neoclide/coc.nvim", branch = "release" },

  { "leafgarland/typescript-vim" },
  { "peitalin/vim-jsx-typescript" },
  { "jparise/vim-graphql" },

  { "othree/html5.vim" },
  { "mattn/emmet-vim" },
  { "andymass/vim-matchup" },
  { "digitaltoad/vim-pug" },

  { "Shougo/vimproc.vim", build = "make" },
  { "bitc/vim-hdevtools" },
  { "eagletmt/ghcmod-vim" },
  { "eagletmt/neco-ghc" },

  { "fidian/hexmode" },
  { "edkolev/tmuxline.vim" },
  { "justinmk/vim-sneak" },
  { "unblevable/quick-scope" },
  { "reasonml-editor/vim-reason-plus" },
  { "vim-erlang/vim-erlang-runtime" },
  { "luochen1990/rainbow" },
  { "pantharshit00/vim-prisma" },

  { "StanAngeloff/php.vim" },
  { "stephpy/vim-php-cs-fixer" },
  { "tpope/vim-dispatch" },
  { "tpope/vim-projectionist" },
  { "noahfrederick/vim-composer" },
  { "noahfrederick/vim-laravel" },
  { "2072/PHP-Indenting-for-VIm" },

  { "leafoftree/vim-vue-plugin" },
  { "posva/vim-vue" },
  {
    "yaegassy/coc-volar",
    build = "yarn install --frozen-lockfile",
  },
  {
    "yaegassy/coc-volar-tools",
    build = "yarn install --frozen-lockfile",
  },

  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npx --yes yarn install",
  },

  { "hashivim/vim-terraform" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  { "pearofducks/ansible-vim" },

  { "nvim-lua/plenary.nvim" },
  { "hrsh7th/nvim-cmp" },
  { "ervandew/supertab" },
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  { "t9md/vim-choosewin" },
  { "github/copilot.vim" },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "github/copilot.vim" },
    },
    config = function()
      require("CopilotChat").setup({
        debug = true,
        mappings = {
          complete = {
            normal = "<C-Space>",
            insert = "<C-Space>",
          },
        },
      })
    end,
  },
}
-- stylua: ignore end
