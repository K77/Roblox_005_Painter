local module = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local S2C_Event_BagChange = ReplicatedStorage:WaitForChild("Remote"):WaitForChild("S2C_Event_BagChange")

--S2C_Event_BagChange.OnClientEvent:Connect(function()
	
--end)
print("S2C_Event_BagChange add listoner")

S2C_Event_BagChange.OnClientEvent:Connect(function(itemName,itemCount)
	print("S2C_Event_BagChange client player: ",itemName,itemCount)
	--print("Client PromptTriggered, playerid: ", player.UserId)
	--if promptObject.Name == "ProximityPromptThrowPoint" then
		local tmp = game.Workspace.RingToThrow:FindFirstChild("RGB"):Clone()
local player = game:GetService("Players").LocalPlayer
		tmp.Parent = game.Workspace.RingToThrow
		tmp:PivotTo(player.Character:GetPivot())
		local TweenService = game:GetService("TweenService")

		local PanelRoot = tmp.PrimaryPart

		local PanelSwingInfo = TweenInfo.new() -- Let's use all defaults here

	local pos1 = game.Workspace.Rewards:WaitForChild(itemName):GetPivot()
		print("kkkkkkkkkkkkkkkkkkkkk pos1: ",pos1)

		local PanelSwingTween = TweenService:Create(PanelRoot, PanelSwingInfo, {
			CFrame = pos1 --PanelRoot.CFrame + Vector3.new(100,0,0)
		})
		print("tweeeeeeeeeeeeeeeeeeeeeeeen")
		PanelSwingTween:Play()
		PanelSwingTween.Completed:Connect(function ()
			tmp:Destroy()
		end
		)
	--end
end)


return module
