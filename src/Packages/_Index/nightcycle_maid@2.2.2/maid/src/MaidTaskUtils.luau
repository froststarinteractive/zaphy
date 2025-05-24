---
-- @module MaidTaskUtils
-- @author Quenty
type DestructibleOOPImpl = {
	__index: DestructibleOOPImpl,
	Destroy: (any) -> ()
}
type DisconnectibleOOPImpl = {
	__index: DisconnectibleOOPImpl,
	Disconnect: (any) -> ()
}
type DestructibleOOP = typeof(setmetatable({}, {} :: DestructibleOOPImpl))
type DisconnectibleOOP = typeof(setmetatable({}, {} :: DisconnectibleOOPImpl))
export type MaidTask =
	{ Disconnect: (any) -> () }
	| { Destroy: (any) -> () }
	| (() -> ()
)	| Instance
	| RBXScriptConnection
	| DestructibleOOP
	| DisconnectibleOOP
	| EditableImage
	| EditableMesh
local MaidTaskUtils = {}

function MaidTaskUtils.isValidTask(job: MaidTask): boolean
	return type(job) == "function"
		or typeof(job) == "RBXScriptConnection" or typeof(job) == "Instance" or typeof(job) == "Object"
		or type(job) == "table"
			and (type((job :: any).Destroy) == "function" or type((job :: any).Disconnect) == "function")
end

function MaidTaskUtils.doTask(job: MaidTask, key: any?): nil
	if type(job) == "function" then
		job()
	elseif typeof(job) == "RBXScriptConnection" then
		job:Disconnect()
	elseif typeof(job) == "Instance" or typeof(job) == "Object" then
		local function isDestroyed(x: any): boolean
			-- if x.Parent then return false end
			local _, result = pcall(function()
				x.Parent = x
			end)
			return result:match("locked") and true or false
		end
		if not isDestroyed(job) then
			pcall(function()
				job:Destroy()
			end)
		end
	elseif type(job) == "table" and type((job :: any).Destroy) == "function" then
		(job :: any):Destroy()
	elseif type(job) == "table" and type((job :: any).Disconnect) == "function" then
		(job :: any):Disconnect()
	else
		print("Job info:", typeof(job))
		print("Key", key)
		if typeof(job) == "table" then
			for k, v in pairs(job) do
				print("\t" .. tostring(k) .. ": " .. tostring(v))
			end
		end
		error("Bad job")
	end
	return nil
end

function MaidTaskUtils.delayed(time: number, job: MaidTask): () -> nil
	assert(type(time) == "number", "Bad time")
	assert(MaidTaskUtils.isValidTask(job), "Bad job")

	return function()
		task.delay(time, function()
			MaidTaskUtils.doTask(job :: any)
		end)
	end
end

return MaidTaskUtils
