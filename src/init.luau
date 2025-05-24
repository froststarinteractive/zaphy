--[[
	
	
 	 _____   _    ____  _   ___   __
	|__  /  / \  |  _ \| | | \ \ / /
 	  / /  / _ \ | |_) | |_| |\ V / 
 	 / /_ / ___ \|  __/|  _  | | |  
	/____/_/   \_\_|   |_| |_| |_|  v2.1.0
	
	
	Made by Froststar Interactive
	
	Contributions:
	- ivadsiuls
	
	Released under the MIT License
]]

local RunService = game:GetService("RunService")

if RunService:IsServer() then
	return require(script:FindFirstChild("ZaphyServer"))
else
	local loaderServer = script:FindFirstChild("ZaphyServer")
	if loaderServer and RunService:IsRunning() then
		loaderServer:Destroy()
	end
	
	return require(script:FindFirstChild("ZaphyClient"))
end