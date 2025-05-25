<div align="center">
<img src="./img/favicon.ico" alt="Icon"/>
<h1>Zaphy Framework</h1>
</div>

-------------------------------------------------------

**Zaphy** is a game framework for Roblox making it easy and fast to create games.

Zaphy is very simplistic and is intended to only give 3 features out-of-the-box:

- A simple module loader
- Extremely easy server-client communication functions
- Pre-bundled utility modules

-------------------------------------------------------

## Installation

To install Zaphy, download the Wally package via:

```toml
Zaphy = "ivadsiuls/zaphy@2.1.4"
```

Run *wally install* to install **Zaphy** into your project

```powershell
wally install
```

-------------------------------------------------------

## Setting up your project

Your VSCode file tree should look something like this:

```
Packages: (these are your wally packages, this includes where Zaphy is stored.)
src:
    modules:
        client:
            Controllers:
        server:
            Services:
        shared:
    scripts:
        client:
            Start.client.luau
        server:
            Start.server.luau
```

Your *project.json* file should look something like this:

```json
{
  "name": "YOUR PROJECT",
  "tree": {
    "$className": "DataModel",

    "ReplicatedStorage": {
      "Shared": {
        "$path": "src/modules/shared"
      },
      "Packages": {
        "$path": "Packages"
      }
    },

    "ServerScriptService": {
      "Server": {
        "$path": "src/modules/server"
      },
      "ServerScripts": {
           "$path": "src/scripts/server"
      }
    },

    "StarterPlayer": {
      "StarterPlayerScripts": {
        "Client": {
          "$path": "src/modules/client"
        },
        "ClientScripts": {
           "$path": "src/scripts/client"
        }
      }
    }
  }
}
```

-------------------------------------------------------

## Starting Zaphy

To start **Zaphy**, create a script in your Server Scripts directory, and require Zaphy:

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:FindFirstChild("Packages")

local Zaphy = require(Packages["Zaphy"])
```

-------------------------------------------------------

### Client

To add your **Controllers** to Zaphy, use Zaphy:AddControllers:

```lua
local Controllers = script.Parent.Parent:FindFirstChild("Client").Controllers:GetDescendants()

Zaphy:AddControllers(Controllers)
```

-------------------------------------------------------

### Server

To add your **Services** to Zaphy, use Zaphy:AddServices:

```lua
local Services = script.Parent.Parent:FindFirstChild("Server").Services:GetDescendants()

Zaphy:AddServices(Services)
```

Lastly, to start Zaphy use:

```lua
Zaphy:StartZaphy()
```