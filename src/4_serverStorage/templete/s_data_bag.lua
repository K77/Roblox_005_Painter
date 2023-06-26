local module = {}
print("ServerData_UserBag begin init")
local DataStoreService = game:GetService("DataStoreService")
local PlayerBagStore = DataStoreService:GetDataStore("PlayerBag")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local S2C_Event_BagChange = ReplicatedStorage.Remote.S2C_Event_BagChange
local C2S_Func_GetAllBag = ReplicatedStorage.Remote.C2S_Func_GetAllBag

local dicBag = {}
local needSave = {}

local function SaveAll(player)
	if player.UserId <= 0 then return end
	local success, err = pcall(function()
		local key = tostring(player.UserId)
		PlayerBagStore:SetAsync(key,dicBag[player.UserId])
		print("save player data to datastore", key, dicBag[player.UserId])
	end)
	if not success then
		print(err)
	end
end

function module.changeItemCount(player,itemName,count)
	local playerId = player.UserId
	print("will save bag: ",playerId, itemName,count,dicBag[player.UserId])
	
	if dicBag[player.UserId][itemName] then
		dicBag[player.UserId][itemName] = dicBag[player.UserId][itemName]+count
	else
		dicBag[player.UserId][itemName] = count
	end

	
	S2C_Event_BagChange:FireClient(player,itemName,dicBag[player.UserId][itemName]) 
	if needSave[player.UserId] then return end
	needSave[player.UserId] = true
	wait(60)
	SaveAll(player)
	needSave[player.UserId] = nil
	--if needSave[player.UserId] then return end
	--needSave[player.UserId] = true
	--wait(6)
	--print("save bag: ",playerId, itemName,count)
	--if playerId <= 0 then return end
	--local success, err = pcall(function()
	--	local key = tostring(playerId ..":" .. "PlayerBag")
	--	PlayerBagStore:SetAsync(key,count)
	--	print("save player data to datastore", key, dicBag[player.UserId])
	--end)
	--if not success then
	--	print(err)
	--end
	--needSave[player.UserId] = nil
end

function module.getPlayerDataFromDataStore(player)
	local playerId = player.UserId
	print("get data: ",playerId, "PlayerBag")

	if playerId <= 0 then return 0 end
	local value = nil
	local success, err = pcall(function()
		local key = tostring(playerId)
		value = PlayerBagStore:GetAsync(key)
		print("get player data from datastore", key, value)
	end)
	if not success then
		print(err)
	end
	return value
end



function module.removePlayerDataFromDataStore(player, dataName)
	local playerId = player.UserId
	print("get data: ",playerId, dataName)

	if playerId <= 0 then return 0 end
	local value = nil
	local success, err = pcall(function()
		local key = tostring(playerId ..":" .. dataName)
		value = PlayerBagStore:RemoveAsync(key)
		print("get player data from datastore", key, value)
	end)
	if not success then
		print(err)
	end
	return value
end

game.Players.PlayerAdded:Connect(function(player)
	print("ServerData_UserBag PlayerAdded: ",player.UserId)
	local items = module.getPlayerDataFromDataStore(player,"PlayerBag")
	if items == nil then items = {} end
	dicBag[player.UserId] = items
end)

game.Players.PlayerRemoving:Connect(function(player)
	SaveAll(player)
	dicBag[player.UserId] = nil
end)

local function GetAllItem(player)
	print("ServerData_UserBag GetAllItem: ",player.UserId)
	return dicBag[player.UserId]
end
C2S_Func_GetAllBag.OnServerInvoke = GetAllItem

return module
