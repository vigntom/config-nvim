# Справочник по плагинам (daily workflow)

Конфиг: **`init.lua`** → **`lazy.nvim`** (`lua/config/lazy.lua`, spec из `lua/plugins/*.lua`). Старого **`settings/*.vim`**, **`plugins.vim`**, **`autoload/plug.vim`** (vim-plug) в загрузке нет.  
**`mapleader`:** пробел `<Space>`. Команда **`:PU`** — синоним **`Lazy sync`** (см. `lua/commands.lua`).

Как читать: сначала блок **«Быстрые хоткеи»**, затем **по файлам spec** и **стек LSP**.

---

## Роли ALE и coc

| Слой | За что отвечает |
|------|------------------|
| **coc.nvim** | LSP, completion (попап), много серверов/расширений из `g:coc_global_extensions`, часть диагностик (HTML/CSS и т.д. по серверам). |
| **ALE** | Линт/фикс через CLI (eslint, hlint, prettier, stylua…), **без** дублирования tsserver/vue LSP с coc (см. комментарии в `lua/plugins/ale.lua`). |

Глобальные флаги в **`init.lua`:** `g:ale_disable_lsp`, `g:ale_completion_enabled = 0`.

**Lua (coc-lua) в этом репозитории:** в **`coc-settings.json`** заданы `Lua.diagnostics.globals` → `vim`, `Lua.runtime.version` → `LuaJIT`, `Lua.workspace.checkThirdParty` → false — чтобы не было предупреждений вроде *Undefined global `vim`* при редактировании `lua/**/*.lua`.

Ключи вида **`diagnostic-languageserver.*`** (расширение **coc-diagnostic**) в `coc-settings.json` не используются: схема JSON в редакторе на них ругалась, а PHP **phpcs / phpcbf** перенесены в **ALE** (`lua/plugins/ale.lua`). При необходимости путь к бинарнику: `g:ale_php_phpcs_executable` и аналоги для phpcbf (см. `:h ale-php`).

---

## Быстрые хоткеи (сводка)

См. `lua/keymaps/editor.lua`, `integrations.lua`, `coc.lua`.

| Клавиши | Действие |
|---------|----------|
| `<Leader>` | пробел |
| `jk` | выход из insert |
| `<Leader> rr` / `rn` | relativenumber / number toggle |
| `<C-L>` | `:nohlsearch` + redraw (если не занято) |
| `<Leader> p` | вставка с выравниванием отступов |
| `<F5>` | `source $MYVIMRC` |
| `<F2>` | paste mode (глобально); в **haskell** буфере перекрывается на `HdevtoolsClear` |
| `<F6>` | **Oil** (буфер каталога); после паузы на `<Leader>` подсказки **which-key** |
| `<F7>` | Undotree |
| `<F8>`, `<Leader> tt` | Tagbar |
| `<F9>` | `gg=G` |
| `<Leader> zf` / `zb` / `zl` | FZF: Files / Buffers / MRU |
| `<Leader> zc` | FZF: Cursor Agent chats (resume; см. `:CursorChats`) |
| `<Leader> tc` | ColorToggle (подсветка `#hex`) |
| `ga` | EasyAlign |
| `<Leader> j` / `k` | EasyMotion |
| `-` | choosewin (выбор окна) |
| `<Leader> ht` / `htc` | GhcModType / Clear |
| `w!!` (command-line) | сохранить через sudo |
| `<C-j>` / `<C-k>` | ALE: следующая/предыдущая ошибка |
| в **haskell**: `<Leader> ?` | ALE: детали под курсором |

**Agentic.nvim** (`lua/plugins/agentic.lua`): **выключен** (`enabled = false`). Раньше: **`<leader>o`**, ACP **`cursor-acp`** с **`agent acp`**. Включить — `enabled = true` в spec.

**Avante.nvim** (`lua/plugins/avante.lua`): **выключен** (`enabled = false`); кастомный конфиг в файле сохранён для экспериментов.

**`cursoragent.nvim`** (`lua/plugins/cursor_cli.lua`): **выключен** (`enabled = false`), спеки и хоткеи сохранены для быстрого отката; раньше те же **`oc` / `oa` / `op` / `or` / `ob` / `os`** вели на `:CursorAgent*`.

**Основной путь по чатам Cursor** — **FZF** (sqlite + `~/.cursor/chats`): **`<Leader> zc`** и **`:CursorChats`** → `lua/cursor_chats.lua` (`cursor-agent --resume=…` в сплите). Имеет смысл вынести позже в отдельный локальный lazy-spec при желании.

Внутри **`cursor-agent`** / ACP CLI по-прежнему доступны slash-команды (например **`/rename`**), если провайдер их отдаёт.

**coc (insert):** `<Tab>` / `<S-Tab>`, `<CR>`, `<C-Space>` — completion. **Copilot / CopilotChat** сейчас **выключены** в `extras.lua` (нет конфликта `<C-Space>` с CopilotChat; при повторном включении — проверь `:verbose imap <C-Space>`).

**coc (normal):** `[g` / `]g` диагностики, `gd` `gy` `gi` `gr`, `K` дока, `<Leader> f` формат выделения, `<Leader> ac` code action, `<Leader> qf` fix. Команды: `:Format`, `:Fold`, `:OR`.

**Опции без отдельного плагина:** в `lua/options.lua` — в visual `p` → `"_dP` (paste без перезаписи unnamed).

---

## Где лежат spec

| Файл | Назначение |
|------|------------|
| `lua/commands.lua` | пользовательские команды (**`:PU`** → `Lazy sync`, **`:CursorChats`**) |
| `lua/plugins/init.lua` | импорт модулей ниже |
| `lua/plugins/colorscheme.lua` | цветовые схемы |
| `lua/plugins/ui.lua` | airline, **which-key**, startify, мелкий UI |
| `lua/plugins/ale.lua` | ALE + часть хоткеев |
| `lua/plugins/general.lua` | «широкий» набор: fzf, git, теги, дерево, и т.д. |
| `lua/plugins/languages.lua` | coc, web/vue/php/haskell/treesitter, emmet, preview |
| `lua/plugins/extras.lua` | surround, choosewin, …; copilot/CopilotChat **disabled** |
| `lua/plugins/agentic.lua` | **Agentic.nvim** (**`enabled = false`**) |
| `lua/plugins/avante.lua` | **Avante.nvim** (**`enabled = false`**) |
| `lua/plugins/cursor_cli.lua` | `cursoragent.nvim` (**`enabled = false`**) |
| `lua/cursor_chats.lua` | FZF picker чатов Cursor + resume в терминале (не lazy-plugin) |

---

## Цветовые схемы (`colorscheme.lua`)

Пакеты тем: mustang, janah, noctu, base16, Zenburn, mango, awesome-vim-colorschemes, nova.  
Активная тема задаётся в **`lua/options.lua`** / событиях (например `VimEnter` с mustang — см. твой `options`).

---

## UI и старт (`ui.lua`)

| Плагин | Зачем в работе |
|--------|----------------|
| **vim-airline** | Статус/tabline; интеграция ALE в строке; tmuxline preset. |
| **vim-airline-themes** | Темы к airline. |
| **which-key.nvim** | Подсказки по префиксам (например после `<Space>`); `VeryLazy`, `delay` 300 ms. |
| **vim-startify** | Стартовый экран: закладки на `init.lua`, lazy, keymaps и команды `r`/`u`/`Lazy`. |
| **BufOnly** | Команды в духе «закрыть прочие буферы» (`:BufOnly` и т.п. — см. `:h` плагина). |
| **editorconfig-vim** | Уважение `.editorconfig`. |
| **NrrwRgn** | Узкая правка региона во временный буфер. |
| **vim-titlecase** | Типографика/titlecase текста (или через `:call` — см. репозиторий). |

---

## ALE (`ale.lua`)

- Линтеры/фиксеры по `ft` (eslint, prettier, stylua, hlint, flake8, …).  
- **fix on save** включён.  
- Хоткеи: `<C-j>` / `<C-k>`, haskell `<Leader>?`.

---

## Общие утилиты (`general.lua`)

| Плагин | Зачем | Как дергаешь |
|--------|--------|----------------|
| **delimitMate** | Авто-пары скобок в insert | автоматически |
| **vim-caddyfile** | Синтаксис Caddyfile | по `ft` |
| **fzf** (+ **fzf.vim**) | Нечёткий поиск/команды | `<Leader> zf/zb`, `:Files` и др. |
| **fzf-mru** | MRU | `<Leader> zl` |
| **vim-easy-align** | Выравнивание | `ga` (normal/visual) |
| **undotree** | История правок | `<F7>` |
| **oil.nvim** | Файловый буфер вместо дерева; скрытые файлы включены (`view_options.show_hidden`) | `<F6>`, `:Oil` |
| **nerdtree** | *`enabled = false`* — не используешь, смотри Oil + FZF |
| **vim-easymotion** | Прыжки | `<Leader> j/k` |
| **vim-commentary** | `gc` комментарии | `gcc`, `gc` в visual |
| **vim-fugitive** | Git | `:Git`, `:Gstatus`, … |
| **committia.vim** | Удобный commit buffer | при `git commit` |
| **vim-gitgutter** | Знаки изменений в жёлобе | автоматически; свои команды `:h gitgutter` |
| **asyncrun.vim** | Асинхронные задачи | JS: правка через `standard --fix` на сохранение `.js` |
| **tagbar** | Структура файла | `<F8>`, `<Leader> tt` — нужен **ctags** в `PATH` (Arch/Manjaro: `sudo pacman -S ctags`; сообщение *Exuberant ctags not found* = бинарник не установлен). |
| **Colorizer** (`Chrisbra/Colorizer`) | Подсветка цветовых кодов | `:ColorToggle`, `<Leader> tc` |

---

## Языки, coc и тяжёлый фронт (`languages.lua`)

### coc.nvim

Основной LSP+completion. Расширения перечислены в **`g:coc_global_extensions`** (JSON/TS/Go/HTML/Volar/tailwind/docker/prisma/sql/yaml/markdown/emmet/blade/… и т.д.).

Полезные семейства команд: `:CocCommand`, `:CocList`, `:CocInstall`. Точные имена команд зависят от расширений — смотри `:CocList extensions` и README расширений.

### coc-fzf-preview

Обход списков coc через fzf (если используешь команды из этого расширения).

### Emmet (`emmet-vim`)

Раскрытие аббревиатур для перечисленных `FileType` (установка `EmmetInstall` через autocmd в spec).

### Web/JS/CSS/vue

Плюс синтаксис/отступы: vim-javascript, vim-js, vim-jsx-pretty, json, yajs, jspc, mustache, sort-imports, typescript-vim, vim-jsx-typescript, graphql, html5, pug, **vim-vue** / **vim-vue-plugin**, **coc-volar** + **coc-volar-tools** (отдельные spec с `build` под yarn).

### Haskell

**vim-hdevtools** — буферные `<F1>` тип, `<F2>` clear.  
**ghcmod-vim**, **neco-ghc** — `:GhcModType` и т.д., хоткеи `<Leader> ht/htc` в integrations.  
Плюс ALE линтеры и `<Leader>?`.

### Прочее по файлам

- **vim-matchup** — улучшенный `%` по парам.  
- **vimproc** — внешние команды (зависимость/наследие; `build = make`).  
- **hexmode** — просмотр бинарников как hex.  
- **tmuxline.vim** — строка для tmux в связке с airline.  
- **vim-sneak** / **quick-scope** — быстрый поиск по `f`/`F`/`s`.  
- **rainbow** — раскраска скобок.  
- **vim-reason-plus**, **erlang-runtime** — под языки.  
- **vim-prisma** — Prisma schema.  
- **php.vim**, **php-cs-fixer**, **PHP-Indenting**, **vim-composer**, **vim-laravel** — PHP/Laravel.  
- **vim-dispatch**, **vim-projectionist** — задачи и навигация по проекту.  
- **markdown-preview.nvim** — превью markdown в браузере (см. команды плагина, часто `:MarkdownPreview`).  
- **coc-markdown-preview-enhanced** — альтернативный/доп. превью через coc.  
- **vim-terraform** —/terraform подсветка и удобства.  
- **nvim-treesitter** — дерево синтаксиса (`:TSUpdate` в build).  
- **ansible-vim** — Ansible.

---

## Extras (`extras.lua`)

| Плагин | Зачем |
|--------|--------|
| **plenary.nvim** | Библиотека Lua (CopilotChat и др., если включишь). |
| **nvim-cmp** | **Отключён** (`enabled = false`); completion через coc. |
| **supertab** | Наследие; см. взаимодействие с coc `<Tab>` в insert. |
| **vim-surround** | `ys`, `ds`, `cs` вокруг текста. |
| **vim-repeat** | Повтор для surround/sneak и совместимых плагинов. |
| **vim-choosewin** | `<Plug>(choosewin)` на `-`. |
| **copilot.vim** | *`enabled = false`* — вернуть в `extras.lua` + `coc-copilot` в `languages.lua`. |
| **CopilotChat.nvim** | *`enabled = false`* — тот же пакет; `config` в spec сохранён для будущего включения. |

---

## Обновление списка плагинов

После правок spec:

```bash
nvim +"Lazy sync" +qa
```

Актуальный lock: **`lazy-lock.json`**.

---

## Что добавить сюда позже

- Короткие **сессионные сценарии** («открыл TS-проект», «правлю Haskell», «markdown») с 5–7 командами подряд.  
- При **включении Copilot** снова: разрулить **`<C-Space>`** (coc vs CopilotChat) и вернуть **`coc-copilot`** в список расширений coc.  
- Тонкая настройка **cursoragent** (`terminal_cmd`, MCP, diff) — по `lua/cursoragent/config.lua` в репозитории плагина.
