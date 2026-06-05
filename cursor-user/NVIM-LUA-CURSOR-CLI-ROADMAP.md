# Neovim + Lua + Cursor CLI Roadmap

Дорожная карта перехода на новый workflow: `neovim` как основной редактор, `cursor cli` как AI-помощник.

## Цель

- Перевести конфиг с Vimscript на Lua поэтапно и без регрессий.
- Перейти на `lazy.nvim`.
- Интегрировать один плагин для Cursor CLI.
- Закрепить рабочий процесс "анализ -> маленький шаг -> проверка".

## Текущее состояние

- Entrypoint: **`init.lua`** → `options` → `commands` → `keymaps` → `autocmds` → **`lazy.nvim`**. **`settings/*.vim`**, **`plugins.vim`**, **vim-plug** из загрузки убраны; **`:PU`** в `lua/commands.lua` вызывает **`Lazy sync`**.
- Опции, автокоманды и ключевые мапы в **`lua/options.lua`**, **`lua/autocmds.lua`**, **`lua/keymaps/*.lua`**; плагины в **`lua/plugins/*.lua`**.
- Правила/skills/agents/commands и playbook/sync уже подготовлены.

## Фаза 1: Lua-база без смены плагинов

1. Создать `init.lua` как entrypoint.
2. Создать `lua/options.lua`, `lua/keymaps.lua`, `lua/commands.lua`.
3. ~~Fallback `source settings/*.vim`~~ — снят; всё в Lua-модулях.
4. Сверить ключевые хоткеи и базовый запуск.

Критерий завершения:
- Neovim стартует стабильно.
- Базовые хоткеи и команды работают как раньше.

## Фаза 2: Переход на lazy.nvim

Цель: **объявление плагина и его `init`/`config` в одном месте** (spec в `lua/plugins/*.lua`), менеджер — **lazy.nvim**, lockfile — `lazy-lock.json`.

**Загрузка:** если существует **`init.lua`**, Neovim **не** читает `init.vim` (см. `:h initialization`). Единый entrypoint — **`init.lua`**. Порядок: `g:ale_*` → модули → `require("config.lazy")` (без последующего `source` legacy `settings/*.vim`).

### 2.0 Инвентаризация (исторически из бывшего `plugins.vim` / vim-plug)

Учесть особые случаи при переносе в spec:

| Тип | Примеры в твоём списке | В lazy |
|-----|-------------------------|--------|
| Кастомный путь + `build` | `fzf` с `dir: ~/.config/nvim/plugsrc/fzf` | `dir` + `build` / `run` |
| Ветка | `coc.nvim` → `release` | `branch = "release"` |
| `build` / постустановка | `markdown-preview.nvim`, `vimproc`, `coc-volar*`, treesitter `:TSUpdate` | `build` функция или строка |
| Ленивая загрузка (было `{ 'on': ... }`) | Colorizer на `ColorToggle` | `cmd = "ColorToggle"` или `keys` |
| Дубликат | `plenary.nvim` дважды | одна зависимость / один spec |
| Lua сразу после менеджера | CopilotChat (`extras.lua`); бывший `plugin_globals` | в `init`/`config` соответствующих spec |

При разборе старых списков `Plug`: либо не включать в spec, либо `enabled = false` для документации.

### 2.1 Bootstrap (первый реальный шаг)

1. Добавить каталог для lazy (обычно `~/.local/share/nvim/lazy` через `vim.fn.stdpath("data") .. "/lazy"`).
2. Файл например `lua/config/lazy.lua` (или `lua/lazy_bootstrap.lua`):
   - клон/путь к `folke/lazy.nvim`;
   - `require("lazy").setup({ spec = { ... } }, { ... })`;
   - spec старта: **`import = "plugins"`** — подгрузка всех модулей из `lua/plugins/*.lua`.
3. В **`init.lua`** после `require("options")` … вызвать **один** `require("config.lazy")` (bootstrap lazy).
4. ~~Не смешивать vim-plug с lazy~~ (сделано: один менеджер — lazy).

Проверка: `nvim --headless -i NONE "+qall"`, затем интерактивно `:Lazy` открывается, список плагинов не пустой.

### 2.2 Первая партия плагинов (smoke)

Цель — убедиться, что rtp, build и порядок жизненного цикла ок.

Рекомендуемый минимальный первый набор:

- Тема **`croaker/mustang-vim`** (уже нужна для `VimEnter` в `options.lua`).
- **`vim-airline/vim-airline`** + **`vim-airline/vim-airline-themes`**: связанные `g:` в **`init`** первого spec в `lua/plugins/ui.lua`.

Миграция шла **партиями** в `lua/plugins/*.lua` (без второго менеджера).

### 2.3 Порядок загрузки (исторически vs бывший `settings/config.vim`)

**Сделано:** бывший `config.vim` разнесён по `lua/options.lua`, `lua/autocmds.lua`, `lua/plugins/*`; файлы **`settings/*.vim`** удалены.

С lazy:

- То, что **должно быть до** загрузки плагина — в **`init`** соответствующего spec (или в общем `options`/`plugin bootstrap`, если это глобальные флаги типа `g:ale_disable_lsp` из `init.lua`).
- То, что **после** — в **`config`**.
- Общий тяжёлый vimscript-блок можно ещё долго держать в `vim.cmd [[ ... ]]` внутри `config`, а потом нарезать по файлам.

Критерий: после каждой партии — те же ручные проверки (ALE, coc, fzf keys), что и сейчас.

### 2.4 Дальнейшие партии (порядок переноса)

1. **Базовые утилиты и Git:** plenary, fugitive, gitgutter, commentary, surround, repeat, undotree, …
2. **Поиск:** fzf + fzf.vim + fzf-mru (сохранить `dir`/`build`).
3. **ALE + связанные `g:`** — в `lua/plugins/ale.lua` (+ `init.lua` для флагов ALE/coc).
4. **coc.nvim + серверы** (отдельный spec, `branch`, `build` при необходимости).
5. **CopilotChat** — в `lua/plugins/extras.lua` (сейчас `enabled = false` при желании можно включить).
6. Остальные языковые/узкие — по файлам или по `ft`.

### 2.5 Завершение фазы

- ~~vim-plug / `plugged`~~ убраны из конфига; **`autoload/plug.vim`** (и backup) удалены — это был bootstrap vim-plug. Каталог **`plugged`** при наличии можно удалить вручную.
- Архив старого списка — в истории **git** (файл **`plugins.vim`** в репо удалён).
- Зафиксировать **`lazy-lock.json`** в git (как принято для воспроизводимости).

Критерий завершения фазы 2:

- Плагины работают эквивалентно состоянию до миграции.
- Нет критичных regressions в daily workflow.
- Новые плагины добавляются одним файлом в `lua/plugins/`.

### 2.6 После bootstrap: аудит, справочник, настройка под себя

**Не забыть: `nvim-cmp` и дублирование со стеком completion**

- **`coc.nvim`** — основной LSP/complete; **`nvim-cmp`** в spec с **`enabled = false`** (см. `PLUGINS-HANDBOOK.md`).
- В `init.lua` уже **`g:ale_disable_lsp`**, **`g:ale_completion_enabled = 0`** — оркестрация шла вокруг coc/ALE, а не вокруг cmp.
- **На потом:** если перейдёшь на **native LSP + cmp**, явно включить cmp, источники и убрать пересечения с coc; иначе запись в spec можно **удалить** вместо `enabled = false`.

**Справочник по плагинам (handbook)**

- Пройтись по установленным плагинам (в т.ч. через `:Lazy`, профили при необходимости): что **активно используется в daily workflow**, что **исторический балласт**, что **требует донастройки** (`config`, `ft`/`event`, ключи, интеграция с coc/ALE).
- Результат — **один документ**, привязанный к **воркфлоу** (не сухой README репозитория): коротко *зачем плагин*, *как дергаешь в работе* (команды/лидер/автозапуск). **Ведётся:** [`cursor-user/PLUGINS-HANDBOOK.md`](./PLUGINS-HANDBOOK.md).
- Опционально позже — **расширенная версия** с примерами: типовые сессии (редактирование X, поиск, git, превью markdown, …) и какие плагины в них участвуют.

**«Пора и себя подтюнить»**

- Имеется в виду осознанно пройти: *как работаешь руками* ↔ *что реально даёт конфиг*; убрать лишнее, довести недонастроенное, задокументировать привычки в том же справочнике.

Дальше по желанию: **lazy-триггеры** (`event`/`ft`/`cmd`) для ускорения старта, сессионные сценарии в handbook.

## Фаза 3: Cursor CLI интеграция

**Текущее состояние (2026-05):**

| Путь | Статус | Примечание |
|------|--------|------------|
| **`lua/cursor_chats.lua`** + `<Leader> zc` / `:CursorChats` | **основной** | FZF → `cursor-agent --resume`, vsplit + termopen |
| **`:AIChatOpen`** / **`:AIChatClose`** | есть | `lua/commands.lua` — tab под агента |
| **`cursoragent.nvim`** | `enabled = false` | spec сохранён, `<leader>o*` |
| **`agentic.nvim`** (ACP `agent acp`) | `enabled = false` | diff, winbar model — на потом |
| **`avante.nvim`** (ACP Cursor recipe) | `enabled = false` | экспериментальный запас |
| **Журнал трения** | ведётся | [`../docs/cursor-cli-workflow-friction.md`](../docs/cursor-cli-workflow-friction.md) |

**Решение:** не четвёртый чат-плагин, а **оркестратор** (picker + terminal CLI + опционально ACP).

**Связь с карьерным планом:** `~/workspace/career-docs/content/learning-roadmap-2026.md` (Balun + Go + доли времени).

Критерий фазы 3 (достигнут для daily):

- [x] `command -v cursor-agent` или `agent`
- [x] Resume чатов из `~/.cursor/chats` через FZF
- [x] Нет двух Agent UI (закрытие `cursoragent.terminal` перед termopen)
- [ ] Pet v0.1 упакован (см. **Фаза 6**)

Старый смоук `<leader>oc` — только если снова включишь `cursor_cli.lua`.

---

## Фаза 6: Pet-плагин `nvim-cursor-sessions` — scope v0.1 (2 недели)

**Цель:** вынести рабочий `cursor_chats` в lazy-spec с `:help`, не ломая coc/fzf/ALE.

**Не в v0.1:** полный ACP UI, парсинг всех blobs, замена Cursor IDE.

### Неделя 1

| День | Шаг | Проверка |
|------|-----|----------|
| 1 | Создать `plugsrc/nvim-cursor-sessions/` (или отдельный git repo) | структура `lua/`, `plugin/`, `README.md` |
| 1 | Перенести логику из `cursor_chats.lua` → `lua/nvim-cursor-sessions/init.lua` | `:CursorChats` работает |
| 2 | Lazy spec в `lua/plugins/cursor_sessions.lua`, старый файл — thin re-export или удалить после smoke | `<Leader> zc` |
| 2 | Зависимости: `fzf.vim`, `sqlite3` в README | `:help cursor-chats` |
| 3 | Опция `open_mode = "vsplit"` \| `"tab"` (tab → логика `:AIChatOpen`) | оба режима вручную |
| 4–5 | Обновить `PLUGINS-HANDBOOK.md` + friction.md ссылку | handbook актуален |

### Неделя 2

| День | Шаг | Проверка |
|------|-----|----------|
| 1 | `:help` всех команд и `<Leader> zc` | help tags |
| 2 | `nvim --headless "+qall"` + ручной smoke (zc, resume, wrong ws) | нет регрессий |
| 3 | Commit в ветке `refactor/nvim-lua-ai`, тег `cursor-sessions-v0.1` | git |
| 4 | Опционально: 30 сек gif / скрин для README | портфолио |
| 5 | Буфер: issue «CursorChatLog / blobs» → v0.2 | backlog |

### Must-have v0.1 (чеклист)

- [x] FZF picker всех чатов, сортировка по `createdAt`
- [x] `--resume` + `--workspace` при совпадении hash
- [x] vsplit termopen, `sink*` (без двойного callback)
- [ ] Lazy-plugin + lock в `lazy-lock.json`
- [ ] `open_mode` vsplit \| tab
- [ ] `:help` + README (deps: sqlite3, fzf, cursor-agent)

### v0.2 (после v0.1, не смешивать)

1. **`:CursorChatLog`** — исследовать `store.db` (`meta` + `blobs`), буфер с user/assistant ([friction §2026-04-05](../docs/cursor-cli-workflow-friction.md)).
2. **`use_acp = true`** — включить `agentic.nvim` только для diff / add-to-context; term path остаётся default.
3. Winbar model label (из `agentic.lua`).

### Архитектура (для Balun / собеса — 2 min draw)

```text
User → :CursorChats → fzf (sqlite meta) → pick chat_id
     → termopen(cursor-agent --resume) [vsplit|tab]
     → optional: agent acp (agentic) if use_acp
```

### Проверки v0.1

```bash
nvim --headless -i NONE "+qall"
command -v cursor-agent agent sqlite3 fzf
# в nvim: :CursorChats, <Leader>zc, resume, :AIChatOpen --resume=<id>
```

## Фаза 4: Закрепление workflow

1. На каждую задачу: `/analyze`.
2. Делать только один маленький шаг за раз.
3. После каждого шага запускать проверки.
4. Для багов использовать `/incident` + `root-cause-debug`.
5. Для релизов использовать `/deploy-plan` + `safe-deploy-checklist`.

Критерий завершения:
- Нет крупных "слепых" правок.
- Задачи закрываются серией проверяемых шагов.

## Фаза 5: Финализация

1. ~~Legacy `settings/*.vim`, `plugins.vim`~~ — удалены; остальное приведение в порядок по мере практики.
2. Обновить playbook по итогам практики.
3. Оставить минимальный набор AI-инструментов без перегруза.
4. **Pet v0.1** завершён (Фаза 6) — один вход для чатов, ACP по флагу.

## Статус фаз (сводка)

| Фаза | Статус |
|------|--------|
| 1 Lua-база | done |
| 2 lazy.nvim | done |
| 3 Cursor CLI | **daily ok**, pet не упакован |
| 4 Playbook workflow | in progress |
| 5 Финализация | ongoing |
| **6 Pet v0.1** | **next** |

## Проверки на каждом этапе

```bash
nvim --headless -i NONE "+qall"
nvim --headless "+qall"
git diff -- .
```

Плюс ручной smoke-check:
- keymaps
- plugin loading
- lint/format
- LSP/completion

## Риски и защита

- Риск: поломка привычных хоткеев -> проверка топ-маппингов после каждого шага.
- Риск: конфликты AI-плагинов -> использовать один Cursor CLI плагин на старте.
- Риск: **два движка completion** (coc + `nvim-cmp` без явной роли) -> дубли попапов, путаница, лишняя загрузка; см. **§2.6**.
- Риск: большой неконтролируемый diff -> миграция только малыми партиями.
