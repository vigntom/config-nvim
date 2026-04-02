# Cursor User Config Snapshot

Этот каталог хранит версионируемый срез пользовательских настроек Cursor:

- `skills/`
- `agents/`
- `commands/`
- `settings/settings.json`
- `PLAYBOOK.md` (памятка ежедневной работы)
- `NVIM-LUA-CURSOR-CLI-ROADMAP.md` (дорожная карта миграции workflow)
- `CURRENT-CONFIG-ASSESSMENT.md` (диагностика legacy-конфига перед миграцией)

## Что не хранить

Не добавляй сюда runtime-артефакты из `~/.cursor`:

- `projects/`
- `extensions/`
- `logs/`
- `cache/`
- любые токены, ключи и секреты

## Обновление snapshot

Обновляй файлы вручную или скриптом, затем проверяй diff перед коммитом.

### Автообновление одной командой

```bash
./scripts/sync-cursor-user.sh
git status --short
```
