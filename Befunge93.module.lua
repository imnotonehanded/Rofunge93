local builtin_ints = require(script.builtin_ints)
local util = require(script.util)
local exts = require(script.exts)

Befunge = {}
Befunge.__index = Befunge

function Befunge.new(code, plr)
	local _befunge = setmetatable({}, Befunge)
	local file = string.split(code.Text,"\n")
	local gui =  script.VisualBefunge:Clone()
	gui.Parent = plr.PlayerGui
	local cell = script.cell
	_befunge.Settings = {
		0, --1 line length
		0, --2 line count
		0,--3 dir
		1, -- 4 x
		1, -- 5 y
	}
	_befunge.stack = {0}
	_befunge.handlers = {}
	_befunge.rhandlers = {}
	for _, v in ipairs(file) do
		local len_ = #v
		if len_ > _befunge.Settings[1] then
			_befunge.Settings[1] = len_
			gui.Frame.UIGridLayout.FillDirectionMaxCells = len_
		end
	end
	
	_befunge.Settings[2] = #file
	local program = {}
	
	for i = 1, _befunge.Settings[2] do
		
		local tmplist = {}
		for j = 1, _befunge.Settings[1] do
			table.insert(tmplist, j,  " ")
		end
		table.insert(program, i, tmplist)
	end
	for line = 1, #file do
		for char = 1, #file[line] do
			local tcell = cell:Clone()
			tcell.Parent = gui.Frame
			tcell.Name = `{char},{line}`
			tcell.Text = string.split(file[line], "")[char]
			program[line][char] = string.split(file[line], "")[char]
		end
	end
	_befunge.gui = gui
	_befunge.program = program
	return _befunge
end

function Befunge:register(character, func, unused)
	self.handlers[character] = func
end

function Befunge:reglist(characters, func, unused)
	for character in ipairs(characters) do
		self.rhandlers[characters[character]] = func
	end
end

function Befunge:handle(character)
	if self.handlers[character] then
		self.Settings, self.program, self.stack = self.handlers[character](self.Settings, self.program, self.stack)
	elseif self.rhandlers[character] then
		self.Settings, self.program, self.stack = self.rhandlers[character](self.Settings, self.program, self.stack, character)
	else
		warn(`{character} not supported`)
		return 
	end
end

function Befunge:run()
	while true do
		local char = self.program[self.Settings[5]][self.Settings[4]]
		self.gui.Frame:FindFirstChild(`{self.Settings[4]},{self.Settings[5]}`).BackgroundColor3 = Color3.new(85, 170, 0)
		
		self:handle(char)
		self.Settings = util.newpos(self.Settings)
		wait(0.1)
		self.gui.Frame:FindFirstChild(`{self.Settings[4]},{self.Settings[5]}`).BackgroundColor3 = Color3.new(1, 1, 1)
	end
end

return Befunge
