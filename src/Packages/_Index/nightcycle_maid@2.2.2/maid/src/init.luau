local Maid = require(script:WaitForChild('Maid'))
local MaidTaskUtils = require(script:WaitForChild('MaidTaskUtils'))

export type Maid = Maid.Maid
export type MaidTask = MaidTaskUtils.MaidTask
export type MaidConstructor = {
	isValidTask: (job: MaidTask) -> boolean,
	doTask: (job: MaidTask, key: any?) -> nil,
	delayed: (time: number, job: MaidTask) -> () -> nil,
	new: () -> Maid
}

local interface: MaidConstructor = {
	isValidTask = MaidTaskUtils.isValidTask,
	doTask = MaidTaskUtils.doTask,
	delayed = MaidTaskUtils.delayed,
	new = Maid.new,
}

return interface
