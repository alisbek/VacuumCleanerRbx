-- CreateRobotUI.lua (LocalScript)
-- Ensures each player gets a minimal RobotUI ScreenGui if none present
local Players = game:GetService("Players")

local function createUIFor(player)
    local playerGui = player:WaitForChild("PlayerGui")
    if playerGui:FindFirstChild("RobotUI") then return end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "RobotUI"

    local battery = Instance.new("TextLabel")
    battery.Name = "BatteryIndicator"
    battery.Size = UDim2.new(0,200,0,30)
    battery.Position = UDim2.new(0,10,0,10)
    battery.Text = "Battery: --"
    battery.Parent = screenGui

    local dust = Instance.new("TextLabel")
    dust.Name = "DustCounter"
    dust.Size = UDim2.new(0,200,0,30)
    dust.Position = UDim2.new(0,10,0,50)
    dust.Text = "Dust: --"
    dust.Parent = screenGui

    local status = Instance.new("TextLabel")
    status.Name = "StatusPanel"
    status.Size = UDim2.new(0,200,0,30)
    status.Position = UDim2.new(0,10,0,90)
    status.Text = "Status: --"
    status.Parent = screenGui

    screenGui.Parent = playerGui
end

Players.PlayerAdded:Connect(function(player)
    createUIFor(player)
end)

-- For studio test when script runs after player exists
for _, player in pairs(Players:GetPlayers()) do
    createUIFor(player)
end
