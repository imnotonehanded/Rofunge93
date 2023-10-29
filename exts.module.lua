exts = {}
exts.__index = exts

function exts.new()
	local _exts = setmetatable({}, exts)
	_exts.extensions = {}
	return _exts
end

function exts:registerall(program, regfunc, reglist)
	for _, ext in pairs(self.extensions) do

		local extension = require(script[ext])
		extension.register(program, regfunc, reglist)
	end
end

function exts:registerext(extension)
	table.insert(self.extensions, extension)
end

return exts
