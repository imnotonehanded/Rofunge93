local util = require(script.Parent.util)
local builtin_ints = {}
-- https://esolangs.org/wiki/Befunge#Instructions what each function does relating to syntax
function builtin_ints.bp_right(_settings, program, stack)
	-- sets the direction to 0 
	_settings[3] = 0
	return _settings, program, stack
end

function builtin_ints.bp_down(_settings, program, stack)
	-- sets the direction to 1
	_settings[3] = 1
	return _settings, program, stack
end

function builtin_ints.bp_left(_settings, program, stack)
	-- sets the direction to 2
	_settings[3] = 2
	return _settings, program, stack
end

function builtin_ints.bp_up(_settings, program, stack)
	-- sets the direction to 3
	_settings[3] = 3
	return _settings, program, stack
end

function builtin_ints.bp_str(_settings, program, stack)
	--prints the text until exited
	_settings = util.newpos(_settings)
	--gets x and y
 	local char = program[_settings[5]][_settings[4]]
	while char ~= '"' do
		
		util.push(stack, string.byte(char))
		_settings = util.newpos(_settings)
		--gets new x, y
		char = program[_settings[5]][_settings[4]]
	end
	return _settings, program, stack
end

function builtin_ints.bp_dup(_settings, program, stack)
	--checks if the length is more than 0 and then pushes the current stack to a newstack
	if #stack > 0 then
		util.push(stack, stack[-1])
	else
		util.push(stack, 0)
	end

	
	return _settings, program, stack
end


function builtin_ints.bp_hif(_settings, program, stack)
	--sets the direction to right if no stack
	if util.pop(stack) == 0 then
		_settings[3] = 0
	else
		_settings[3] = 2
	end
	return _settings, program, stack
end

function builtin_ints.bp_pst(_settings, program, stack)
	--prints the last item of stack
	print(string.char(util.pop(stack)))
	return _settings, program, stack
end

function builtin_ints.bp_end(_settings, program, stack)
	error("Ended program")
	return 
end

function builtin_ints.bp_int(_settings, program, stack, character)
	util.push(stack, math.round(character))
	return _settings, program, stack
end

function builtin_ints.bp_add(_settings, program, stack)
	local a = util.pop(stack)
	local b = util.pop(stack)
	util.push(stack, a + b)
	return _settings, program, stack
end

function builtin_ints.bp_sub(_settings, program, stack)
	local a = util.pop(stack)
	local b = util.pop(stack)
	util.push(stack, b - a)
	return _settings, program, stack
end

function builtin_ints.bp_mul(_settings, program, stack)
	local a = util.pop(stack)
	local b = util.pop(stack)
	util.push(stack, a * b)
	return _settings, program, stack
end

function builtin_ints.bp_div(_settings, program, stack)
	local a = util.pop(stack)
	local b = util.pop(stack)
	util.push(stack, b / a)
	return _settings, program, stack
end

function builtin_ints.bp_mod(_settings, program, stack)
	local a = util.pop(stack)
	local b = util.pop(stack)
	util.push(stack, b % a)
	return _settings, program, stack
end

function builtin_ints.bp_not(_settings, program, stack)
	local last = util.pop(stack)
	if last == 0 then
		last = 1
	else
		last = 0
	end
	util.push(stack, last)
	return _settings, program, stack
end

function builtin_ints.bp_grt(_settings, program, stack)
	local a = util.pop(stack)
	local b = util.pop(stack)
	local last
	if b > a then
		last = 1
	else
		last = 0
	end
	util.push(stack, last)
	return _settings, program, stack
end

function builtin_ints.bp_vif(_settings, program, stack)
	if util.pop(stack) == 0 then
		_settings[2] = 1
	else
		_settings[2] = 3
	end
	return _settings, program, stack
end

function builtin_ints.bp_swp(_settings, program, stack)
	local a = util.pop(stack)
	local b = util.pop(stack)
	util.push(stack, a)
	util.push(stack, b)
	return _settings, program, stack
end

function builtin_ints.bp_pop(_settings, program, stack)
	util.pop(stack)
	return _settings, program, stack
end

function builtin_ints.bp_pin(_settings, program, stack)
	print(util.pop(stack))
	return _settings, program, stack
end

function builtin_ints.bp_brd(_settings, program, stack)
	_settings = util.newpos(_settings)
	return _settings, program, stack
end

function builtin_ints.bp_get(_settings, program, stack)
	local y = util.pop(stack)
	local x = util.pop(stack)
	local last
	if x >= _settings[0] or y >= _settings[1] or x < 0 or y < 0 then
		last = 0
	else
		local getline = program[y]
		last = string.byte(getline[x])
		util.push(stack, last)
	end
	return _settings, program, stack
end

function builtin_ints.bp_put(_settings, program, stack)
	local y = util.pop(stack)
	local x = util.pop(stack)
	local v = util.pop(stack)
	if x < _settings[0] or y < _settings[1] or x >= 0 or y >= 0 then
		local getline = program[y]
		getline[x] = v
		program[y] = getline 
	end
	return _settings, program, stack
end

function builtin_ints.bp_rnd(_settings, program, stack)
	_settings[2] = math.random(0, 3)
	return _settings, program, stack
end

function builtin_ints.bp_gin(_settings, program, stack)	
	print("W.I.P.")
	--util.push(stack, int(input()))
	return _settings, program, stack
end

function builtin_ints.bp_gch(_settings, program, stack)
	print("W.I.P.")
	return _settings, program, stack
end

function builtin_ints.bp_ssp(_settings, program, stack, character)
	return _settings, program, stack
end

function builtin_ints.register(program, regfunc, reglist)
	regfunc( program, '>', builtin_ints.bp_right)
	regfunc( program, 'v', builtin_ints.bp_down)
	regfunc( program, '<', builtin_ints.bp_left)
	regfunc( program, '^', builtin_ints.bp_up)
	regfunc( program, '"', builtin_ints.bp_str)
	regfunc( program, ':', builtin_ints.bp_dup)
	regfunc( program, '_', builtin_ints.bp_hif)
	regfunc( program, ',', builtin_ints.bp_pst)
	regfunc( program, '@', builtin_ints.bp_end)
	reglist(program, {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'}, builtin_ints.bp_int)
	regfunc( program, '+', builtin_ints.bp_add)
	regfunc( program, '-', builtin_ints.bp_sub)
	regfunc( program, '*', builtin_ints.bp_mul)
	regfunc( program, '/', builtin_ints.bp_div)
	regfunc( program, '%', builtin_ints.bp_mod)
	regfunc( program, '!', builtin_ints.bp_not)
	regfunc( program, '`', builtin_ints.bp_grt)
	regfunc( program, '|', builtin_ints.bp_vif)
	regfunc( program, '\\', builtin_ints.bp_swp)
	regfunc( program, '$', builtin_ints.bp_pop)
	regfunc( program, '.', builtin_ints.bp_pin)
	regfunc( program, '#', builtin_ints.bp_brd)
	regfunc( program, 'g', builtin_ints.bp_get)
	regfunc( program, 'p', builtin_ints.bp_put)
	regfunc( program, '?', builtin_ints.bp_rnd)
	regfunc( program, '&', builtin_ints.bp_gin)
	regfunc( program, '~', builtin_ints.bp_gch)
	reglist(program, {'\t', '\n', '\v', '\f', '\r', ' '}, builtin_ints.bp_ssp)
end
		
return builtin_ints
