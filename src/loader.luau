-- Hermes MODULE LOADER (v0.2.0)

--[[
    LOADER EXECUTION MODEL

    loader:Register
        Add all the modules to the cache

    loader:Fly
        Loop through all the modules in the _modules cache
            Require it
            Add the .Server/.Client to it
            Add it to the _providers cache
            Call :Init on it

        Loop through all the providers in the _providers cache
            Call :Start on it
            Connect to lifecycle methods
]]
--

local RunService = game:GetService("RunService")
local isClient = RunService:IsClient()

local modding = require("./modding")
local component = require("./component")

local loader = {
	_modules = {},
	_providers = {},

	Component = component,
}

export type loader = typeof(loader)

export type Provider = {
	Name: string,

	Hermes: loader,

	Init: (Provider) -> ()?,
	Start: (Provider) -> ()?,

	Heartbeat: (Provider) -> ()?,

	[any]: any,
}

export type ProviderServer = Provider & {}

export type ProviderClient = Provider & {
	PreRender: (ProviderClient) -> ()?,
	PreSimulation: (ProviderClient) -> ()?,
}

-- Register a table of ModuleScripts to the Hermes module cache to be loaded when :Fly is called.
function loader.Register(self: loader, modules: { ModuleScript })
	for _, module in modules do
		if not table.find(self._modules, module) then
			modding.ProviderRegistered:Fire()
			table.insert(self._modules, module)
		else
			warn("Attempt to add module already in the cache.")
		end
	end
end

-- Requires a table of ModuleScripts
function loader.RequireModules(_self: loader, modules: { ModuleScript })
	for _, module in modules do
		require(module)
	end
end

-- Starts Hermes and all the modules in its cache.
function loader.Fly(self: loader)
	--[[
        This is where we added all the modules in the cache to the providers cache
        and call the "Init" function on all of them.

		-- !DO NOT YIELD! --
    ]]
	for _, module in self._modules :: { ModuleScript } do
		local prov = require(module)

		assert(prov.Name,`[Hermes] Provider from module "{module.Name}" does not have a 'Name' index!`)
		-- or
		-- if not prov.Name then warn(`[Hermes] Provider from module "{Module.Name}" does not have a 'Name' index, setting to Module name`) prov.Name = module.Name end

		if self._providers[prov.Name] then
			warn("There is already a provider with the same name! Provider names MUST be unique.")
			return
		end

		prov.Hermes = self

		self._providers[prov.Name] = prov

		if prov.Init then
			prov:Init()
		end
	end

	--[[
        This is where we call all the provider's "Start" function,
        and connect the lifecycle methods as well.

		-- !DO NOT YIELD! --
    ]]
	for _, prov in self._providers :: { [string]: Provider } do
		if prov.Start then
			prov:Start()
		end

		if prov.Heartbeat then
			RunService.Heartbeat:Connect(function(dt)
				prov:Heartbeat(dt)
			end)
		end

		if isClient then
			if prov.PreRender then
				RunService.PreRender:Connect(function(dt)
					prov:PreRender(dt)
				end)
			end

			if prov.PreSimulation then
				RunService.PreSimulation:Connect(function(dt)
					prov:PreSimulation(dt)
				end)
			end
		end
	end

	modding.StartedFlying:Fire()
	modding.Flying = true
end

-- Gets a provider from Hermes's provider cache. Returns nil if it was not found.
function loader.Use(self: loader, name: string): Provider?
	return self._providers[name]
end

-- Alias for loader:Use
function loader.UseProvider(self: loader, name: string): Provider?
	return self:Use(name)
end

return loader
