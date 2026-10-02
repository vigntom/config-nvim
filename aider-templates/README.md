# Aider Templates

Шаблоны промптов, конфигов и стеков для Aider.

## Структура

```
aider-templates/
├── README.md                    # этот файл
├── install.sh                   # создание симлинков
├── prompts/                     # базовые промпты (отдельные)
│   ├── base.md
│   ├── react.md
│   ├── node.md
│   ├── php.md
│   ├── go.md
│   └── python.md
├── stacks/                      # готовые комбо (base + стек)
│   ├── fullstack-js.md
│   ├── frontend-react.md
│   ├── backend-node.md
│   ├── backend-php.md
│   ├── backend-go.md
│   └── backend-python.md
├── configs/                     # конфиги Aider
│   ├── aider.conf.yml           # глобальный конфиг (алиасы, модели)
│   ├── aider.model.settings.yml # настройки моделей
│   └── aider.model.metadata.json # метаданные (контекст, цены)
└── project-templates/           # шаблоны для проектов
    ├── .aider.conf.yml          # проектный конфиг
    └── CONVENTIONS.md           # проектные правила
```

## Установка

```bash
# 1. Создать структуру
mkdir -p ~/.config/nvim/aider-templates/{prompts,stacks,configs,project-templates}

# 2. Скопировать файлы (см. репозиторий)

# 3. Создать симлинки
bash ~/.config/nvim/aider-templates/install.sh
```

## Использование

### Глобально

`~/.aider.conf.yml` — симлинк на `configs/aider.conf.yml`. Содержит:

- Основную модель
- Алиасы (fast, reason, coder, local, pro)
- Настройки автокоммитов

### В проекте

1. Скопируй `project-templates/.aider.conf.yml` в корень проекта.
2. Раскомментируй нужный стек в `read:`.
3. При необходимости — скопируй `CONVENTIONS.md` для проектных правил.
4. Запусти `aider`.

### Пример `.aider.conf.yml` в проекте

```yaml
read:
  - ~/.config/nvim/aider-templates/stacks/fullstack-js.md
  - ./CONVENTIONS.md
```

## Стеки

| Стек | Файл | Для чего |
|------|------|----------|
| Fullstack JS | `stacks/fullstack-js.md` | React + Node |
| Frontend React | `stacks/frontend-react.md` | Только фронт |
| Backend Node | `stacks/backend-node.md` | Express/Fastify/NestJS |
| Backend PHP | `stacks/backend-php.md` | Laravel |
| Backend Go | `stacks/backend-go.md` | Go |
| Backend Python | `stacks/backend-python.md` | FastAPI/Flask |

## Модели

### Алиасы

| Режим | base | next | alt | alt-next | top | top-next |
|-------|------|------|-----|----------|-----|----------|
| **fast** | GPT-6 Luna Pro | DeepSeek V4.1 Flash | Qwen3-Coder-Next | Grok 4.20 | Claude Haiku 4.5 | GLM-5.3 Flash |
| **reason** | DeepSeek R1 | GPT-6.1 Sol | Gemini 3.1 Pro | Kimi K3 | GPT-6.1 Sol Pro | Claude Opus 4.6 |
| **coder** | Qwen3-Coder-Next | DeepSeek V4 Pro | GPT-5.6 Terra | Muse Spark 1.3 | Claude Opus 4.6 | Gemini 3.1 Pro |
| **local** | qwen2.5-coder:3b | qwen2.5-coder:7b | — | — | — | — |
| **pro** | GPT-6.1 Sol Pro | Claude Opus 4.6 | GPT-6.1 Sol | Gemini 3.1 Pro | GPT-6 Astra | — |

### Переключение

```
/model fast          # рутина
/model reason        # сложная логика
/model coder         # код
/model local         # офлайн
/model pro           # максимальная эффективность
```

## Принципы

1. **Маленькие шаги.** Одно изменение за раз.
2. **Сначала анализ, потом код.** Неясно — спроси.
3. **Не трогай лишнее.** Точечно, не «перепиши всё».
4. **Стиль как в проекте.** Не навязывай свой.
5. **Тесты если есть.** После правки — прогони.

## Обновление

Шаблоны можно версионировать в git. Симлинки создаются через `install.sh`.

Если добавил новый стек — обнови `README.md` и `install.sh` (если нужно).

## TODO

- [ ] Скрипт автообновления `aider.model.metadata.json` (RouterAI → Aider)
- [ ] Скрипт для проверки актуальности цен
- [ ] Шаблоны для тестирования и рефакторинга
```

---

