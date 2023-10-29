local util = require(script.Parent.Parent.util)
local newline = {}
function newline.pnl(settings, program, stack)
	util.push(stack, 10)
	return settings, program, stack
end

function newline.register(program, regfunc, reglist)
	regfunc(program, 'n', newline.pnl)
end

return newline
