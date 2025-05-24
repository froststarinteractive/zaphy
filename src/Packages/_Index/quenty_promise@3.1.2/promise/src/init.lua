return setmetatable({
	-- Core
	PromiseUtils = require(script.Shared.PromiseUtils);
	Promise = require(script.Shared.Promise);

	-- Utility
	PendingPromiseTracker = require(script.Utility.PendingPromiseTracker);
	PromiseInstanceUtils = require(script.Utility.PromiseInstanceUtils);
	promiseChild = require(script.Utility.promiseChild);
	promisePropertyValue = require(script.Utility.promisePropertyValue);
	promiseWait = require(script.Utility.promiseWait);
}, {
	__index = require(script.Shared.Promise);
})