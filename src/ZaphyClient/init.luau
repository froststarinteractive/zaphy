--[=[
	@class ZaphyClient

	The client part of Zaphy.
]=]

local Packages = ( script.Parent :: Instance ).Parent

local Net = require(Packages:FindFirstChild("Net"))

local loader = {
	debugEnabled = false,
	
	Util = {
		Signal = require(Packages:FindFirstChild("Signal")),
		Maid = require(Packages:FindFirstChild("Maid")),
	}
}

local ClientModules = {}

-- TYPES

--[=[
	@interface Controller
	.Name string
	.[any] any
	@within ZaphyClient
]=]
type Controller = {
	Name: string,
	[any]: any,
}

-- LOCAL FUNCTIONS

local function printDebug(string: string)
	if loader.debugEnabled then
		print(string)
	end
end

-- PUBLIC FUNCTIONS

--[=[
	-- Adds controllers to the Controllers table.
]=]
function loader:AddControllers(clientModules: {ModuleScript})
	for _, module in clientModules do
		task.spawn(function()
			local reqmodule = require(module)

			table.insert(ClientModules, reqmodule)
		end)
	end
end


--[=[
	-- Starts Zaphy. Calls Init functions for all controllers, then calls Start functions for all controllers shortly after.
]=]
function loader:StartZaphy()
	local startTime = tick()
	
	for i, module in ClientModules do
		printDebug(`Initializing and starting Controllers {i}/{#ClientModules}`)

		if module.Init then
			task.spawn(function()
				module:Init()
			end)
		end
	end
	
	for _, module in ClientModules do
		if module.Start then
			task.spawn(function()
				module:Start()
			end)
		end
	end
	
	warn(`💻 CLIENT LOADED: {tick() - startTime}s`)
end

--[=[
	-- Gets all Zaphy controllers.

	@return {{Name: string, [any]: any}} -- Returns all Zaphy controllers
]=]
function loader:GetControllers()
	return ClientModules
end

--// TO BE USED IN ZAPHY CONTROLLERS

--// GET FUNCTIONS


--[=[
	Get a module initiated by Zaphy. Returns nil if a module does not exist/wasn't loaded.

	@param ControllerName string -- Name of the controller.
	@return {Name: string, [any]: any} -- Returns the named controller.
]=]
function loader:GetController(ControllerName: string): Controller
	for _, v in loader:GetControllers() do
		if v.Name == ControllerName then
			return v
		end
	end

	error(`Could not find controller "{ControllerName}". Check to verify a controller with this name exists.`, 2)
end

--// SERVER/CLIENT COMMUNICATION FUNCTIONS

--[=[
	-- Ask the server to do something.

	@param RemoteName string -- Name of the remote.
    @param ... ... -- Name of the remote.
]=]
function loader:AskServer(RemoteName: string, ...)
	if Net:RemoteEvent(RemoteName) then
		Net:RemoteEvent(RemoteName):FireServer(...)
	else
		warn("Remote not found!")
	end
end

--[=[
	-- Ask the server to do something, uses unreliable remove events.

	@param RemoteName string -- Name of the remote.
    @param ... ... -- Name of the remote.
]=]
function loader:UnreliablyAskServer(RemoteName: string, ...)
	if Net:UnreliableRemoteEvent(RemoteName) then
		Net:UnreliableRemoteEvent(RemoteName):FireServer(...)
	else
		warn("Unreliable remote not found!")
	end
end

--[=[
	-- Listens for when the Server uses :TellClient or :TellAllClients and triggers the given callback.

	@param RemoteName string -- Name of the remote.
    @param Callback (any) -> () -- Callback to be triggered
    @return RBXScriptConnection
]=]
function loader:ListenTellFromServer(RemoteName: string, Callback: (any) -> ())
	return Net:RemoteEvent(RemoteName).OnClientEvent:Connect(function(...)
		Callback(...)
	end)
end

--[=[
    -- Listens for when the Server uses :UnreliablyTellClient or :UnreliablyTellAllClients and triggers the given callback.

	@param RemoteName string -- Name of the remote.
    @param Callback (any) -> () -- Callback to be triggered
    @return RBXScriptConnection
]=]
function loader:ListenUnreliableTellFromServer(RemoteName: string, Callback: () -> ())
	return Net:UnreliableRemoteEvent(RemoteName).OnClientEvent:Connect(function(...)
		Callback(...)
	end)
end

return loader