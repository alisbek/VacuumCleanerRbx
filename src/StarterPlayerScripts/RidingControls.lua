local UserInputService = game:GetService("UserInputService")
local RobotControl = game.ReplicatedStorage.RemoteEvents.RobotControl


local player = game.Players.LocalPlayer
local ridingRobot = nil

RobotControl.OnClientEvent:Connect(function(robotName, action)
	if action == "RIDE" then
		local robot = workspace.Robots:FindFirstChild(robotName)
		if robot then
			ridingRobot = robot
			-- Attach player to robot
			player.Character:SetPrimaryPartCFrame(robot.PrimaryPart.CFrame)
			player.Character.HumanoidRootPart.Anchored = true
			-- Camera follow
			workspace.CurrentCamera.CameraSubject = robot.PrimaryPart
		end
	elseif action == "STOPRIDE" then
		ridingRobot = nil
		player.Character.HumanoidRootPart.Anchored = false
		workspace.CurrentCamera.CameraSubject = player.Character.Humanoid
	end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not ridingRobot or gameProcessed then return end
	local speed = 16
	if input.KeyCode == Enum.KeyCode.W then
		ridingRobot.PrimaryPart.CFrame = ridingRobot.PrimaryPart.CFrame + ridingRobot.PrimaryPart.CFrame.LookVector * speed * 0.1
	elseif input.KeyCode == Enum.KeyCode.S then
		ridingRobot.PrimaryPart.CFrame = ridingRobot.PrimaryPart.CFrame - ridingRobot.PrimaryPart.CFrame.LookVector * speed * 0.1
	elseif input.KeyCode == Enum.KeyCode.A then
		ridingRobot.PrimaryPart.CFrame = ridingRobot.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(-10), 0)
	elseif input.KeyCode == Enum.KeyCode.D then
		ridingRobot.PrimaryPart.CFrame = ridingRobot.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(10), 0)
	end
end)
