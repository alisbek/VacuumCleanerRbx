-- Script: RobotAI
-- Handles robot autonomous movement, obstacle avoidance, dust seeking, battery logic
local Robots = workspace.Robots
local DockingStations = workspace.DockingStations
local DustFolder = workspace.Dust
local RobotStats = require(game.ReplicatedStorage.RobotStats)
local RobotControl = game.ReplicatedStorage.RemoteEvents.RobotControl

local RobotState = {}

-- Utility: Raycast for obstacles
local function isPathClear(robot)
    local sensor = robot:FindFirstChild("Sensor")
    if not sensor then return true end
    local ray = Ray.new(sensor.Position, sensor.CFrame.LookVector * 3)
    local hit = workspace:FindPartOnRay(ray, robot)
    return hit == nil
end

-- Utility: Find nearest dust
local function findNearestDust(robot)
    local nearest = nil
    local minDist = math.huge
    for _, dust in pairs(DustFolder:GetChildren()) do
        local dist = (robot.PrimaryPart.Position - dust.Position).Magnitude
        if dist < minDist then
            minDist = dist
            nearest = dust
        end
    end
    return nearest
end

-- Move robot toward target
local function moveTo(robot, target, speed)
    if not robot.PrimaryPart or not target then return end
    local direction = (target.Position - robot.PrimaryPart.Position).Unit
    robot.PrimaryPart.CFrame = robot.PrimaryPart.CFrame + direction * speed * 0.1
end

-- Main robot movement logic
function moveRobot(robot, stats)
    if not robot.PrimaryPart then return end
    -- Obstacle avoidance
    if not isPathClear(robot) then
        robot.PrimaryPart.CFrame = robot.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(45), 0)
        return
    end
    -- Seek dust
    local dust = findNearestDust(robot)
    if dust then
        moveTo(robot, dust, stats.Speed)
        if (robot.PrimaryPart.Position - dust.Position).Magnitude < 2 then
            dust:Destroy()
            robot:SetAttribute("DustCollected", (robot:GetAttribute("DustCollected") or 0) + 1)
        end
    else
        -- Random walk if no dust
        robot.PrimaryPart.CFrame = robot.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(math.random(-10,10)), 0)
    end
    -- Battery drain
    local battery = robot:GetAttribute("BatteryCurrent") or stats.BatteryMax
    battery = battery - 0.1
    robot:SetAttribute("BatteryCurrent", battery)
    -- Dock if battery low
    if battery < stats.BatteryMax * 0.1 then
        require(script.Parent.DockingLogic).dockRobot(robot)
    end
end

function moveRobot(robot, stats)
    -- TODO: Implement raycasting for obstacle avoidance
    -- TODO: Seek nearest dust
    -- TODO: Drain battery, check dust capacity
    -- TODO: Return to dock if battery low
end

RobotControl.OnServerEvent:Connect(function(player, robotName, action)
    -- action: "ON", "OFF", "RIDE", "DOCK"
    if action == "ON" then
        RobotState[robotName] = "ON"
    elseif action == "OFF" then
        RobotState[robotName] = "OFF"
    elseif action == "DOCK" then
        local robot = Robots:FindFirstChild(robotName)
        if robot then
            require(script.Parent.DockingLogic).dockRobot(robot)
        end
    end
    -- RIDE handled by RidingControls client
end)

while true do
    for _, robot in pairs(Robots:GetChildren()) do
        local stats = RobotStats[robot.Name]
        if RobotState[robot.Name] == "ON" then
            moveRobot(robot, stats)
        end
    end
    task.wait(0.1)
end
