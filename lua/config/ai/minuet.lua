local providers = require("config.ai.providers")
local models = require("config.ai.models")

-- Список поддерживаемых языков для автотриггера
local supported_fts = {
	"lua",
	"python",
	"php",
	"javascript",
	"javascriptreact",
	"typescript",
	"typescriptreact",
	"vue",
	"go",
}

-- Общие клавиатурные сочетания для виртуального текста
local minuet_keymap = {
	accept = "<A-A>",
	accept_line = "<A-a>",
	accept_n_lines = "<A-z>",
	prev = "<A-[>",
	next = "<A-]>",
	dismiss = "<A-e>",
}

-- Первая модель для указанного провайдера
local function first_model_for(provider_name)
	for _, m in ipairs(models) do
		if m.provider == provider_name then
			return m
		end
	end
end

-- Собрать provider_options для minuet
local function build_provider_options(provider_conf, model_id)
	local options = {
		end_point = provider_conf.end_point,
		api_key = provider_conf.api_key_env, -- ← Minuet сам прочитает env
		model = model_id,
		name = provider_conf.name,
		optional = {
			max_tokens = provider_conf.max_tokens,
			top_p = 0.9,
			temperature = provider_conf.temperature or 0.1,
		},
	}

	if provider_conf.provider_type == "openai_compatible" and provider_conf.system_prompt then
		options.system_prompt = provider_conf.system_prompt
	end

	return options
end

-- Вспомогательная функция для сборки базовой структуры конфигурации
local function make_base_config(provider_conf, model_id)
	local provider_options = build_provider_options(provider_conf, model_id)
	local pt = provider_conf.provider_type

	return {
		provider = pt,
		n_completions = 1,
		context_window = provider_conf.context_window,
		request_timeout = 5,
		throttle = provider_conf.throttle,
		debounce = provider_conf.debounce,
		virtualtext = {
			keymap = minuet_keymap,
			auto_trigger_ft = {}, -- По умолчанию пустой, переопределим где надо
		},
		provider_options = {
			[pt] = provider_options,
		},
	}
end

-- Провайдер по умолчанию: Ollama (быстро, бесплатно, FIM)
local default_provider = "ollama"
local default_model = first_model_for(default_provider)

local M = {
	models = models,
	providers = providers,
	default_provider = default_provider,
	default_model = default_model,

	-- Полная конфигурация для minuet.setup() — ВЫКЛЮЧЕНА при старте
	get_setup = function()
		local provider_conf = providers[default_provider]
		local config = make_base_config(provider_conf, default_model.id)

		-- Автотриггер пустой, плагин спит при запуске Neovim
		config.virtualtext.auto_trigger_ft = {}
		return config
	end,

	-- Собрать конфиг для конкретной модели (для MinuetPick) — ВКЛЮЧАЕТ автотриггер
	build_for = function(model)
		local provider_conf = providers[model.provider]
		local config = make_base_config(provider_conf, model.id)

		-- При ручном выборе модели активируем автодополнение для всех языков
		config.virtualtext.auto_trigger_ft = supported_fts
		return config
	end,
}

return M
