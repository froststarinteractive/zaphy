local Packages = ( script.Parent :: Instance ).Parent

local Net = require(Packages:FindFirstChild("Net"))

local loader = {
	debugEnabled = false,
	
	Util = {
		Signal = require(Packages:FindFirstChild("Signal")),
		Maid = require(Packages:FindFirstChild("Maid")),
	}
}

local ServerModules = {}

-- LOCAL FUNCTIONS

local function printDebug(string: string)
	if loader.debugEnabled then
		print(string)
	end
end

-- PUBLIC FUNCTIONS

-- Adds services to the Services table.
function loader:AddServices(serverModules: {ModuleScript})
	for _, module in serverModules do
		task.spawn(function()
			local reqmodule = require(module)

			table.insert(ServerModules, reqmodule)
		end)
	end
end

-- Starts Zaphy. Calls Init functions for all services, then calls Start functions for all services shortly after.
function loader:StartZaphy()
	local startTime = tick()
	
	for i, module in ServerModules do
		printDebug(`Initializing and starting Controllers {i}/{#ServerModules}`)

		if module.Init then
			task.spawn(function()
				module:Init()
			end)
		end
	end
	
	for _, module in ServerModules do
		if module.Start then
			task.spawn(function()
				module:Start()
			end)
		end
	end
	
	warn(`🖥️ SERVER LOADED: {tick() - startTime}s`)
end

-- Gets all Zaphy Services.
function loader:GetServices()
	return ServerModules
end

--// TO BE USED IN ZAPHY SERVICES

--// GET FUNCTIONS

-- Get a module initiated by Zaphy. Returns nil if a module does not exist/wasn't loaded.
function loader:GetService(ModuleName: string)
	for _, v in loader:GetServices() do
		if v.Name == ModuleName then
			return v
		end
	end

	error("Could not find controller.")
	return
end

--// SERVER/CLIENT COMMUNICATION FUNCTIONS

-- Tell the Client to do something.
function loader:TellClient(Player: Player, RemoteName: string, ...)
	Net:RemoteEvent(RemoteName):FireClient(Player, ...)
end

-- Tell the Client to do something, uses unreliable remote events.
function loader:UnreliablyTellClient(Player: Player, RemoteName: string, ...)
	Net:UnreliableRemoteEvent(RemoteName):FireClient(Player, ...)
end

-- Tell all clients to do something.
function loader:TellAllClients(RemoteName: string, ...)
	Net:RemoteEvent(RemoteName):FireAllClients(...)
end

-- Tell all clients to do something, uses unreliable remote events.
function loader:UnreliablyTellAllClients(RemoteName: string, ...)
	Net:UnreliableRemoteEvent(RemoteName):FireAllClients(...)
end

-- Listens for when the Client uses :AskServer and triggers the given callback.
-- Returns an RBXScriptConnection.
function loader:ListenAskFromClient(RemoteName: string, Callback: () -> ())
	return Net:RemoteEvent(RemoteName).OnServerEvent:Connect(function(...)
		Callback(...)
	end)
end

return loader