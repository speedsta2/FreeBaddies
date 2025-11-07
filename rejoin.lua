local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local placeId = game.PlaceId

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.Equals then
		local jobId = game.JobId
		task.defer(function()
			TeleportService:TeleportToPlaceInstance(placeId, jobId, player)
		end)
	end
end)
