-- Доступные модели для автодополнения.
-- provider должен совпадать с ключом в providers.lua.
-- DeepSeek и GLM убраны: DeepSeek уходит в reasoning (пустой ответ),
-- GLM отвечает ~40 секунд — не годится для автодополнения.

return {
	-- Локальные (Ollama, нативный FIM)
	{ id = "qwen2.5-coder:3b", provider = "ollama", label = "Qwen2.5 3B (local FIM)" },

	-- Облачные (RouterAI, chat + system_prompt)
	{ id = "mistralai/codestral-2508", provider = "routerai", label = "Codestral (cloud, fast)" },
	{ id = "qwen/qwen3-coder-next", provider = "routerai", label = "Qwen3 Coder Next (cloud)" },
}
