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

-- Table to quickly check opps
local trackedOpps = {}
for _, userId in ipairs(opps) do
    trackedOpps[userId] = true
end

-- Function to create BillboardGUI above a player's head
local function createOppLabel(player)
    if not player.Character or not player.Character:FindFirstChild("Head") then return end
    local head = player.Character.Head

    -- Avoid duplicates
    if head:FindFirstChild("OppBillboardGui") then return end

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
    textLabel.Text = "OPP\n<font color=\"rgb(255,255,0)\">" .. player.Name .. "</font>"
    textLabel.TextColor3 = Color3.fromRGB(255, 0, 0) -- OPP in red
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextScaled = true
    textLabel.TextStrokeTransparency = 0.2
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.Parent = billboardGui
end

-- Function to notify about a new opp
local function notifyNewOpp(player)
    StarterGui:SetCore("SendNotification", {
        Title = "NEW OPP",
        Text = player.Name,
        Duration = 5
    })
end

-- Function to send notification of all current opps
local function sendOppNotification(opPlayers)
    local amount = #opPlayers
    if amount == 0 then return end

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

-- When a new player joins
Players.PlayerAdded:Connect(function(player)
    if trackedOpps[player.UserId] then
        -- Wait for character to exist
        player.CharacterAdded:Connect(function()
            createOppLabel(player)
        end)
        -- If they already have a character
        if player.Character then
            createOppLabel(player)
        end
        -- Notify about the new opp
        notifyNewOpp(player)
    end
end)

-- Loop to constantly check all players and add OPP if missing
spawn(function()
    while true do
        for _, player in ipairs(Players:GetPlayers()) do
            if trackedOpps[player.UserId] then
                createOppLabel(player)
            end
        end
        wait(0.1) -- check every 0.1 seconds
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
