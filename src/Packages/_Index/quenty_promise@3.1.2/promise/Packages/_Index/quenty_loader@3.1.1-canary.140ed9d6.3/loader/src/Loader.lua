--- Loading logic
-- @module loader

local Queue = require(script.Parent.Queue)

local Loader = {}
Loader.ClassName = "Loader"
Loader.__index = Loader

function Loader.new(script, canLoadDescendants)
	return setmetatable({
		_script = script;
		_canLoadDescendants = canLoadDescendants and true or false;
	}, Loader)
end

local function waitForValue(objectValue)
	local value = objectValue.Value
	if value then
		return value
	end

	return objectValue.Changed:Wait()
end

function Loader:__call(value)
	return self:_load(value)
end

function Loader:__index(value)
	return self:_load(value)
end

function Loader:_load(value)
	if type(value) ~= "string" then
		return require(value)
	end

	local object = self._script.Parent:FindFirstChild(value)
	if object then
		if object:IsA("ObjectValue") then
			return require(waitForValue(object))
		elseif object:IsA("ModuleScript") then
			return require(object)
		end
	end

	if self._canLoadDescendants then
		-- Discover descendant
		local result = self:_recurseDiscover(self._script, value)
		if result then
			return require(result)
		end
	end

	error(("Could not find %s.%s"):forat(self._script:GetFullName(), tostring(value)))
end

function Loader:_recurseDiscover(parent, name)
	local queue = Queue.new()
	queue:PushRight(parent)

	while not queue:IsEmpty() do
		local toProcess = queue:PopLeft()

		for _, child in pairs(toProcess:GetChildren()) do
			if child:IsA("ModuleScript") or child:IsA("ObjectValue") then
				if child.Name == name then
					return child
				end
			elseif child:IsA("Folder") then
				queue:PushRight(child)
			end
		end
	end

	return nil
end

return Loader