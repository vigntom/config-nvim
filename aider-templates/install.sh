#!/bin/bash
# install.sh — создание симлинков для Aider
# Запуск: bash ~/.config/nvim/aider-templates/install.sh

set -e

TEMPLATES="$HOME/.config/nvim/aider-templates"

echo "🔗 Создание симлинков для Aider..."

# Глобальный конфиг Aider
ln -sf "$TEMPLATES/configs/aider.conf.yml" "$HOME/.aider.conf.yml"
echo "  ✓ ~/.aider.conf.yml"

# Настройки моделей
ln -sf "$TEMPLATES/configs/aider.model.settings.yml" "$HOME/.aider.model.settings.yml"
echo "  ✓ ~/.aider.model.settings.yml"

# Метаданные моделей (если есть)
if [ -f "$TEMPLATES/configs/aider.model.metadata.json" ]; then
	ln -sf "$TEMPLATES/configs/aider.model.metadata.json" "$HOME/.aider.model.metadata.json"
	echo "  ✓ ~/.aider.model.metadata.json"
fi

# Базовый промпт (для быстрого доступа)
ln -sf "$TEMPLATES/prompts/base.md" "$HOME/.aider.prompt.md"
echo "  ✓ ~/.aider.prompt.md"

echo ""
echo "✅ Готово. Симлинки созданы."
echo ""
echo "Проверка:"
ls -la "$HOME"/.aider* 2>/dev/null || echo "  (файлы не найдены)"
