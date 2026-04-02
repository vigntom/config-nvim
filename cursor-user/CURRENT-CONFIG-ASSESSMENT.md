# Current Config Assessment (Legacy Vimscript Baseline)

Цель: зафиксировать текущее состояние рабочего legacy-конфига перед переходом на Lua.

## Решение

- Legacy-конфиг не правим точечно без крайней необходимости.
- Все структурные улучшения делаем уже в новой Lua-конфигурации.
- Этот документ — baseline для проверки прогресса миграции.

## Ключевые проблемы (по приоритету)

### High

1. Маппинги на отсутствующие плагины:
   - `NERDTreeToggle` в `settings/mappings.vim`, при отключенном `NERDTree`.
   - `<Plug>(easymotion-...)` маппинги при отключенном `easymotion`.
2. Пересечение completion/LSP-стека:
   - `coc.nvim` + `nvim-cmp` + `supertab` + `copilot.vim` + `CopilotChat.nvim`.
   - Риск конфликтов по `<Tab>`, `<C-Space>`, диагностике и форматированию.
3. Монолитная структура на Vimscript:
   - `init.vim`, `plugins.vim`, `settings/config.vim`, `settings/mappings.vim` как крупные файлы.

### Medium

1. Дубли и конфигурационный шум:
   - `nvim-lua/plenary.nvim` указан дважды в `plugins.vim`.
   - `g:ale_lint_on_save` задается повторно.
   - `set directory-=.` позже переопределяется `set directory=/var/tmp`.
2. Производительность старта:
   - По `--startuptime` старт ~166 ms с заметной долей в `plugins.vim`, `settings/config.vim`, `coc.nvim`, `CopilotChat`.
3. Исторический слой закомментированных фрагментов:
   - Усложняет чтение и повышает стоимость изменений.

## Что это значит для миграции

- Сначала переносим структуру (`init.lua`, `lua/options.lua`, `lua/keymaps.lua`, `lua/commands.lua`) с fallback на legacy.
- Затем мигрируем плагины на `lazy.nvim` группами.
- Отдельно подключаем один плагин для Cursor CLI (без параллельных интеграций).

## Критерии успеха следующего этапа

- Эквивалентное поведение ключевых hotkeys.
- Стабильный старт и отсутствие критичных regressions.
- Малые и проверяемые diff на каждом шаге.
