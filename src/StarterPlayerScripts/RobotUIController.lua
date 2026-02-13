local RobotStats = require(game.ReplicatedStorage.RobotStats)
local DustCollected = game.ReplicatedStorage.RemoteEvents.DustCollected

local player = game.Players.LocalPlayer
local gui = player.PlayerGui:FindFirstChild("RobotUI")
if not gui then return end

local function updateUI(robot)
	local battery = robot:GetAttribute("BatteryCurrent") or 0
	local dust = robot:GetAttribute("DustCollected") or 0
	local status = robot:GetAttribute("Status") or "Unknown"
	gui.BatteryIndicator.Text = "Battery: " .. math.floor(battery) .. "%"
	gui.DustCounter.Text = "Dust: " .. dust
	gui.StatusPanel.Text = "Status: " .. status
end

for _, robot in pairs(workspace.Robots:GetChildren()) do
	robot:GetAttributeChangedSignal("BatteryCurrent"):Connect(function()
		updateUI(robot)
	end)
	robot:GetAttributeChangedSignal("DustCollected"):Connect(function()
		updateUI(robot)
	end)
	robot:GetAttributeChangedSignal("Status"):Connect(function()
		updateUI(robot)
	end)
end
