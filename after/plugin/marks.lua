local config = {
    -- whether to map keybinds or not. default true
    default_mappings = false,
    -- which builtin marks to show. default {}
    mappings = {
        set_next = "ma",
        next = "]m",
        prev = '[m',
        delete_line = 'dm-',
        delete_buf = 'dm<space>',
        preview = "m:",
    }
}

require('marks').setup(config)
