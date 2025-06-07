<div align="center">
<img style="width: 150px; height: 150px" src="https://zen7yjauxo.ufs.sh/f/1qxTIhVVwRptecTAWxolr2l7Uw4YHTMJXSqjNpBmRL9uhfgP" alt="Icon"/>

<h1><b>Zaphy Framework</b></h1>

</div>

-------------------------------------------------------

### WARNING

Zaphy is a **work-in-progress**, there are things that are missing.
Here's what is intended to be added in the future:

<table>
  <tr>
    <th>Feature</th>
    <th>Intended to be added?</th>
  </tr>
  <tr>
    <td>Communication optimization via buffers</td>
    <td>✅ Intended to be added.</td>
  </tr>
  <tr>
    <td>RemoteFunction support</td>
    <td>✅ Intended to be added.</td>
  </tr>
  <tr>
    <td>BindableEvent support</td>
    <td>✅ Intended to be added.</td>
  </tr>
  <tr>
    <td>Better types</td>
    <td>✅ Intended to be added.</td>
  </tr>
  <tr>
    <td>Pesde support</td>
    <td>✅ Intended to be added.</td>
  </tr>
  <tr>
    <td>More packages</td>
    <td>✅ Intended to be added.</td>
  </tr>
  <tr>
    <td>Data handling</td>
    <td>❌ Will never be added.</td>
  </tr>
  <tr>
    <td>Lifecycle methods</td>
    <td>❔ May be added.</td>
  </tr>
</table>

-------------------------------------------------------

**Zaphy** is a game framework for Roblox making it easy and fast to create games.

Zaphy is very simplistic and is intended to give 3 features out-of-the-box:

- A simple module loader
- Extremely easy server-client communication functions
- Pre-bundled utility modules

## Installation

To install Zaphy, download the Wally package via:

```toml
Zaphy = "ivadsiuls/zaphy@2.1.6"
```

Run *wally install* to install **Zaphy** into your project

```powershell
wally install
```

## Setting up your project

Your VSCode file tree should look something like this:

```lua
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
  "name": "Generic Zaphy Game",
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

## Starting Zaphy

To start **Zaphy**, create a script in your Server Scripts directory, and require Zaphy:

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:FindFirstChild("Packages")

local Zaphy = require(Packages.Zaphy)
```

### Server

To add your <a href="/api/server/init"><b>Services</b></a> to Zaphy, use Zaphy:AddServices:

```lua
local Services = script.Parent.Parent:FindFirstChild("Server").Services:GetDescendants()

Zaphy:AddServices(Services)
```

### Client

To add your <a href="/api/client/init"><b>Controllers</b></a> to Zaphy, use Zaphy:AddControllers:

```lua
local Controllers = script.Parent.Parent:FindFirstChild("Client").Controllers:GetDescendants()

Zaphy:AddControllers(Controllers)
```

## Start it!

Lastly, to start Zaphy use:

```lua
Zaphy:StartZaphy()
```