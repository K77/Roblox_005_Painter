-- local module = {}

-- local allClass = {}

-- function module.new(className)
-- 	print(className)
-- 	if className == nil then return	end

-- 	local t = {}
-- 	t.Inited = false
-- 	t.Init = function() end
-- 	t.Process = function() end
-- 	game:GetService("RunService").Stepped:Connect(function(time, deltaTime)
-- 		if t == nil then return end
-- 		if not t.Inited then return end
-- 		t.Process()
-- 	end)
-- 	local v = {}
-- 	setmetatable(v,{__index = t})
-- 	if className ~= nil then allClass[className] = v end
-- 	return v
-- end

-- -- module.Inited = false

-- -- function module.Init ()

-- -- end

-- -- function module.Process ()

-- -- end


-- local RunService = game:GetService("RunService")
-- RunService.Stepped:Connect(function()
-- 	for index, value in allClass do
-- 		if value.Inited then
-- 			value.Process()
-- 		end
-- 	end
-- end)

-- -- module.Inited = true
-- return module
