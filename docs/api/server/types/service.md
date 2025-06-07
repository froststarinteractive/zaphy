# Service
A Zaphy service.

```luau
type Service = {
	Name: string,
    Init: (Service) -> ()?,
    Start: (Service) -> ()?,
	[any]: any,
}
```