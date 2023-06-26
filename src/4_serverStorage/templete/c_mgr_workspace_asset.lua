local module = {}
module.Inited = false
local Workspace = game:GetService("Workspace")

function module.SpawnLocation() return workspace:WaitForChild("SpawnLocation") end


function module.Init ()

end



function module.Process ()

end


local RunService = game:GetService("RunService")
RunService.Stepped:Connect(function()
	if not module.Inited then return end

end)

module.Inited = true
return module
