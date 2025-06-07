# ListenAskFromClient

Listens for when the Client uses :AskServer and triggers the given callback.
Returns an RBXScriptConnection.

```luau
function Zaphy:ListenAskFromClient(
    RemoteName: string,
    Callback: (...) -> ()
): RBXScriptConnection
```