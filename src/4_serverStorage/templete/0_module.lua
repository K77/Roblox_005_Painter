local module = {}
module.Inited = false

function module.Init ()

end

function module.Process ()

end


local RunService = game:GetService("RunService")
RunService.Stepped:Connect(function()
	if not module.Inited then return end
	module.Process()
end)

module.Inited = true
return module
