local status_ok, nrpattern = pcall(require, "nrpattern")
if not status_ok then
	return
end

local patterns = require("nrpattern.default")

patterns[{ "yes", "no" }] = { priority = 5 }
patterns[{ "true", "false" }] = { priority = 5 }

require("nrpattern").setup(patterns)
