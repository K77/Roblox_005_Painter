local module = {}

local allClass = {}

function module.new(className)
	print(className)
	-- if className == nil then return	end

	local t = {}
	t.Inited = false
	t.Init = function() end
	t.Process = function() end

	t.Players = game:GetService("Players");

	local v = {}
	setmetatable(v,{__index = t})

	game:GetService("RunService").Stepped:Connect(function(time, deltaTime)
		if v == nil then return end
		if not v.Inited then return end
		v.Process()
	end)

	return v
end

-- module.Inited = false

-- function module.Init ()

-- end

-- function module.Process ()

-- end


-- local RunService = game:GetService("RunService")
-- RunService.Stepped:Connect(function()
-- 	for index, value in allClass do
-- 		if value.Inited then
-- 			value.Process()
-- 		end
-- 	end
-- end)

-- module.Inited = true
return module
