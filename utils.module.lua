local util = {}

function util.pop(stack)
	if #stack == 0 then 
		return 0
	else
		return table.remove(stack)
	end
end

function util.push(stack, num)
	table.insert(stack, num)
end

function util.newpos(_settings)
	if _settings[3] == 0 then
		if _settings[4] == _settings[1] then
			_settings[4] = 1
		else
			_settings[4] += 1
		end
	elseif _settings[3] == 1 then
		if _settings[5] == _settings[2] then
			_settings[5] = 1
		else
			_settings[5] += 1
		end
	elseif _settings[3] == 2 then
		if _settings[4] == 0 then
			_settings[4] = _settings[1] -1
		else
			_settings[4] -= 1
		end
	elseif _settings[3] == 3 then
		
		if _settings[5] == 0 then
			_settings[5] = _settings[2] -1
		else
			_settings[5] -= 1
		end
	end
	return _settings
end
return util
