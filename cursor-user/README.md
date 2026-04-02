# Cursor User Config Snapshot

Этот каталог хранит версионируемый срез пользовательских настроек Cursor:

- `skills/`
- `agents/`
- `commands/`
- `settings/settings.json`

## Что не хранить

Не добавляй сюда runtime-артефакты из `~/.cursor`:

- `projects/`
- `extensions/`
- `logs/`
- `cache/`
- любые токены, ключи и секреты

## Обновление snapshot

Обновляй файлы вручную или скриптом, затем проверяй diff перед коммитом.
