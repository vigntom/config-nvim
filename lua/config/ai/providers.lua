-- Настройки провайдеров для автодополнения.
-- Ollama — нативный FIM, локально (MacBook 10.20.30.6).
-- RouterAI — chat-based + жёсткий system_prompt.

return {
	-- Локальный Ollama (нативный FIM)
	ollama = {
		name = "Ollama",
		provider_type = "openai_fim_compatible",
		end_point = "http://10.20.30.6:11434/v1/completions",
		api_key_env = "TERM",
		context_window = 128,
		throttle = 400,
		debounce = 100,
		max_tokens = 64,
		temperature = 0.1,
	},

	-- RouterAI (chat-based, system_prompt = псевдо-FIM)
	routerai = {
		name = "RouterAI",
		provider_type = "openai_compatible",
		end_point = "https://routerai.ru/api/v1/chat/completions",
		api_key_env = "OPENROUTER_API_KEY", -- у тебя ключ RouterAI в этой переменной
		context_window = 128,
		throttle = 500,
		debounce = 200,
		max_tokens = 64,
		temperature = 0.1,
	},
}
