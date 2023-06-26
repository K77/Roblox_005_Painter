local module = {}
local ProximityPromptService = game:GetService("ProximityPromptService")
local ServerScriptService = game:GetService("ServerScriptService")
local S_Ring2Item = require(ServerScriptService.S_Ring2Item)
-- Detect when prompt is triggered
local function onPromptTriggered(promptObject, player)
	if promptObject.parent == nil then return end
	--if promptObject.parent.Name == "RGB" then
	--	print("ProximityPrompt act: Ring, ",promptObject)
	--	promptObject.parent:Destroy()
	--	player.Money.Value = player.Money.Value+1
	--	return
	--end
	if promptObject.Name == "ProximityPromptThrowPoint" then
		print("ProximityPrompt act: ThrowPoint, ",promptObject)
		S_Ring2Item.GetOneItemUseRing(player)
	end
end

-- Detect when prompt hold begins
local function onPromptHoldBegan(promptObject, player)

end

-- Detect when prompt hold ends
local function onPromptHoldEnded(promptObject, player)

end

-- Connect prompt events to handling functions
ProximityPromptService.PromptTriggered:Connect(onPromptTriggered)
ProximityPromptService.PromptButtonHoldBegan:Connect(onPromptHoldBegan)
ProximityPromptService.PromptButtonHoldEnded:Connect(onPromptHoldEnded)
return module
