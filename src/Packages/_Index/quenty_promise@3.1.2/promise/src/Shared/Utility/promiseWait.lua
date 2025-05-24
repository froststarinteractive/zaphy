--- Wraps the wait()/delay() API in a promise
-- @module promiseWait

local require = require(script:FindFirstAncestorWhichIsA("ModuleScript").Parent.loader).subload(script)

local Promise = require("Promise")

return function(time)
	return Promise.new(function(resolve, _)
		task.delay(time, function()
			resolve()
		end)
	end)
end