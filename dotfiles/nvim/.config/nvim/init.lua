require "options"

local async
async =
    vim.loop.new_async(
    vim.schedule_wrap(
        function()
            require "plugins"
            require "config.bufferline"
            require "mappings"
            require("utils").hideStuff()

            async:close()
        end
    )
)
async:send()
