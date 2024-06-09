require "telescope".setup {
	preview = true,
	file_ignore_patterns = {
		"node_modules/",
		"target/",
		"build/",
		"zig-out/",
		"zig-cache/",
	},
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		-- ..
	},
	pickers = {
		live_grep = {
			additional_args = function() return { "--max-depth=99", } end
		}
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
}
