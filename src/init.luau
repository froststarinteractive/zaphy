--[[
                                                                                                
                                                                                                
    ██╗  ██╗███████╗██████╗ ███╗   ███╗███████╗███████╗ v0.2.0
    ██║  ██║██╔════╝██╔══██╗████╗ ████║██╔════╝██╔════╝
    ███████║█████╗  ██████╔╝██╔████╔██║█████╗  ███████╗
    ██╔══██║██╔══╝  ██╔══██╗██║╚██╔╝██║██╔══╝  ╚════██║
    ██║  ██║███████╗██║  ██║██║ ╚═╝ ██║███████╗███████║
    ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚══════╝
                                                   
                                                                                                

    Hermes is a lightweight module loader for Roblox making game development actually fun.

    This is Hermes's CORE library. Currently, it features a simple module loader.

    This is what we will have in the future:

    - Wally release (probably AFTER networking. I just really like pesde right now lol)
    

    Libraries for Hermes that will exist, but will not be included in its core:

    - Easy data handling
    - Animations

    Credit:
    - inspiration from prvdmwrong v0.1.
    - signal implementation by Quenty
]]

local loader = require("@self/loader")
local networking = require("@self/networking")
local modding = require("@self/modding")
local utils = require("@self/utils")

export type Hermes = loader.loader & networking.networking & modding.modding
export type Provider = loader.Provider
return utils.joinTables(loader, networking, modding, {
	utils = {
		signal = require("@self/utils/signal"),
	},
}) :: Hermes
