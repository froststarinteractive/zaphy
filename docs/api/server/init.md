# Server
The server-side of Zaphy.

A typical Zaphy server-side usage:

Server -> Services -> AwesomeService
```luau
local Zaphy = require(path-to-zaphy)

-- A Zaphy service is just a table with some functions!
local AwesomeService = {}

-- Initialize the service. Not recommended to require other services,
-- as they are still loading as well!
-- Listen to client here (or connect to remotes if you aren't using Zaphy's
-- communication functions (you should))
function AwesomeService:Init()
    print("Zaphy is awesome!")
end

-- Do anything here!
function AwesomeService:Start()
    print("Zaphy is awesome! #2")
end

function AwesomeService:ListenToClientForStuff()
    -- first parameter is the name of the remote event
    -- second is whats triggered when that remote is fired by the client

    -- you should keep remote names unique
    Zaphy:ListenAskFromClient("clientStuff", function(stuffParameter: string)
        print(stuffParameter, "Awesome stuff man!!!!")
    end)
end

-- Zaphy allows custom functions which you can use in other modules!
function AwesomeService:DoStuff()

    -- creates (or gets if it already exists) a remote event and fires it!
    -- first parameter is the name of the remote event
    -- all the other parameters is whatever you want...

    -- only the SERVER can create new remotes.
    Zaphy:TellAllClients("stuffRemote", 123456, "yuh")
end

return AwesomeService
```

Server -> Runtime
```luau
local Zaphy = require(path-to-zaphy)

local Server = script.Parent
local Services = Server.Services

-- AddServices takes in a table of module scripts.
Zaphy:AddServices(Services:GetChildren())

-- Calls init functions for all services
-- then calls start functions for all services

-- TODO: make this function a cooler name
-- startZaphy is a BORING name!1!111!
Zaphy:StartZaphy()

-- Let's use a service:

local service = Zaphy:GetService("AwesomeService")

service:DoStuff()
```