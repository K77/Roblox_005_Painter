local module = {}
local DataStoreService = game:GetService("DataStoreService")
local PlayerDataStore = DataStoreService:GetDataStore("PlayerData")

local function savePlayerDataToDataStore(player,dataName,value)
	local playerId = player.UserId
	print("save data: ",playerId, dataName,value)
	if playerId <= 0 then return end
	local success, err = pcall(function()
		local key = tostring(playerId ..":" .. dataName)
		PlayerDataStore:SetAsync(key,value)
		print("save player data to datastore", key, value)
	end)
	if not success then
		print(err)
	end
end

local function getPlayerDataFromDataStore(player, dataName)
	local playerId = player.UserId
	print("get data: ",playerId, dataName)

	if playerId <= 0 then return 0 end
	local value = nil
	local success, err = pcall(function()
		local key = tostring(playerId ..":" .. dataName)
		value = PlayerDataStore:GetAsync(key)
		print("get player data from datastore", key, value)
	end)
	if not success then
		print(err)
	end
	return value
end

local function removePlayerDataFromDataStore(player, dataName)
	local playerId = player.UserId
	print("get data: ",playerId, dataName)

	if playerId <= 0 then return 0 end
	local value = nil
	local success, err = pcall(function()
		local key = tostring(playerId ..":" .. dataName)
		value = PlayerDataStore:RemoveAsync(key)
		print("get player data from datastore", key, value)
	end)
	if not success then
		print(err)
	end
	return value
end

local needChangeMoney = {}
game.Players.PlayerAdded:Connect(function(player)
	local money = getPlayerDataFromDataStore(player,"Money")
	if money == nil then money = 0 end
	print("money: "..money)
	local Money = Instance.new("NumberValue", player)
	Money.Name = "Money"
	Money.Value = money
	Money.Changed:Connect(function()
		if needChangeMoney[player.UserId] then return end
		needChangeMoney[player.UserId] = true
		wait(60)
		savePlayerDataToDataStore(player,"Money",Money.Value)
		needChangeMoney[player.UserId]  = nil
	end)
end)

game.Players.PlayerRemoving:Connect(function(player)
	savePlayerDataToDataStore(player,"Money",player.Money.Value)
end)
return module