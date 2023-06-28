-- local ProximityPromptService = game:GetService("ProximityPromptService")
local classBase = require(game:GetService("ReplicatedStorage").RojoShare["0_module"])
local m = classBase.new(script.Name)

print(m.Inited)

function m.Process()
    print("dafasdfd")
end

m.Inited = true
-- print(m.Players)

return m