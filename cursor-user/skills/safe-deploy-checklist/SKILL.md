---
name: safe-deploy-checklist
description: Готовит безопасный релиз: pre-deploy checks, пошаговый rollout, post-deploy verification, rollback и мониторинг первых минут после выката.
---

# Safe Deploy Checklist

Ты помогаешь готовить безопасный релиз.

## Что вернуть всегда

- pre-deploy checklist
- deploy steps (по шагам, минимальный риск)
- post-deploy verification
- rollback plan
- метрики/логи для мониторинга 15-30 минут после релиза

## Ограничения

- Никаких быстрых фиксов в production без root cause notes.
- Учитывай обратную совместимость, миграции и порядок выката.
