local reverse = {}
local util = require(script.Parent.Parent.util)


function reverse.rtz(_settings, program, stack)

	local torev = {}
	local val = -1
	while true do
		local val = util.pop(stack)
		if val ~= 0 then
			util.push(torev, val)
		else
			break
		end
		util.push(stack, 0)
		for val in torev do
			util.push(stack, val)
			return _settings, program, stack
		end
	end
end

function reverse.register(program, regfunc, reglist)
	regfunc(program, ';', reverse.rtz)
end
return reverse