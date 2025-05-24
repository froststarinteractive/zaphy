return setmetatable({
	MaidTaskUtils = require(script.Shared.MaidTaskUtils);
	Maid = require(script.Shared.Maid);
}, {
	__index = require(script.Shared.Maid);
})