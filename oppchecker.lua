local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

-- Fetch opps.json
local success, jsonString = pcall(function()
	return game:HttpGet("https://raw.githubusercontent.com/speedsta2/FreeBaddies/main/opps.json")
end)

if not success then
	warn("Failed to fetch opps.json")
	return
end

local jsonData = HttpService:JSONDecode(jsonString)
local opps = jsonData.opps or {}

-- Tables for tracking
local trackedOpps = {}
for _, userId in ipairs(opps) do
	trackedOpps[userId] = true
end

-- Girlfriend and Bestfriend IDs
local girlfriendIDs = {
	[7568387502] = true,
	[7554950077] = true,
	[7562408281] = true,
	[8266698203] = true,
	[8410188693] = true
}

local bestfriendIDs = {
	[2243289395] = true
}

-- Function to create BillboardGUI above a player's head
local function createLabel(player)
	if not player.Character or not player.Character:FindFirstChild("Head") then
		return
	end

	-- Only create label if player matches criteria
	if not (trackedOpps[player.UserId] or girlfriendIDs[player.UserId] or bestfriendIDs[player.UserId]) then
		return
	end

	local head = player.Character.Head

	-- Remove old label if any
	local existing = head:FindFirstChild("OppBillboardGui")
	if existing then
		existing:Destroy()
	end

	local billboardGui = Instance.new("BillboardGui")
	billboardGui.Name = "OppBillboardGui"
	billboardGui.Adornee = head
	billboardGui.Size = UDim2.new(0, 200, 0, 60)
	billboardGui.StudsOffset = Vector3.new(0, 3, 0)
	billboardGui.AlwaysOnTop = true
	billboardGui.Parent = head

	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, 0, 1, 0)
	textLabel.BackgroundTransparency = 1
	textLabel.RichText = true
	textLabel.Font = Enum.Font.SourceSansBold
	textLabel.TextScaled = true
	textLabel.TextStrokeTransparency = 0.2
	textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
	textLabel.Parent = billboardGui

	-- Girlfriend
	if girlfriendIDs[player.UserId] then
		textLabel.TextColor3 = Color3.fromRGB(255, 105, 180) -- Pink
		textLabel.Text = "BABY GIRL\n<font color=\"rgb(255,0,0)\">" .. player.DisplayName .. "</font>"

	-- Bestie
	elseif bestfriendIDs[player.UserId] then
		textLabel.TextColor3 = Color3.fromRGB(0, 255, 0) -- Lime green
		textLabel.Text = "BESTIE\n<font color=\"rgb(128,0,255)\">" .. player.DisplayName .. "</font>"

	-- Opp
	elseif trackedOpps[player.UserId] then
		textLabel.TextColor3 = Color3.fromRGB(255, 0, 0) -- Red
		textLabel.Text = "OPP\n<font color=\"rgb(255,255,0)\">" .. player.DisplayName .. "</font>"
	end
end

-- Function to notify about a new opp
local function notifyNewOpp(player)
	if trackedOpps[player.UserId] then
		StarterGui:SetCore("SendNotification", {
			Title = "NEW OPP",
			Text = player.Name,
			Duration = 5
		})
	end
end

-- Send notification of all current opps
local function sendOppNotification(opPlayers)
	local amount = #opPlayers
	if amount == 0 then
		return
	end

	local title = tostring(amount)
	if amount > 1 then
		title = title .. "'s"
	end

	local description = ""
	for i, player in ipairs(opPlayers) do
		description = description .. player.DisplayName
		if i < amount then
			description = description .. ", "
		end
	end

	StarterGui:SetCore("SendNotification", {
		Title = title .. " in the server",
		Text = description,
		Duration = 5
	})
end

-- When players join
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		createLabel(player)
	end)

	if player.Character then
		createLabel(player)
	end

	if trackedOpps[player.UserId] then
		notifyNewOpp(player)
	end
end)

-- Constantly check players that meet criteria only
task.spawn(function()
	while true do
		for _, player in ipairs(Players:GetPlayers()) do
			if trackedOpps[player.UserId] or girlfriendIDs[player.UserId] or bestfriendIDs[player.UserId] then
				createLabel(player)
			end
		end
		task.wait(0.5)
	end
end)

-- Send notification of all current opps when script starts
local oppPlayers = {}
for _, player in ipairs(Players:GetPlayers()) do
	if trackedOpps[player.UserId] then
		table.insert(oppPlayers, player)
	end
end
sendOppNotification(oppPlayers)
