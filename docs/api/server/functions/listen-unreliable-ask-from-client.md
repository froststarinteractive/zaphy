# ListenUnreliableAskFromClient

Listens for when the Client uses :UnreliablyAskServer and triggers the given callback.
Returns an RBXScriptConnection.

```lua
function Zaphy:ListenUnreliableAskFromClient(
    RemoteName: string,
    Callback: () -> ()
): RBXScriptConnection
```