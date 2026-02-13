-- Script: DockingLogic
local Robots = workspace.Robots
local DockingStations = workspace.DockingStations


-- Utility: Find nearest docking station
local function findNearestDock(robot)
    local nearestDock = nil
    local minDist = math.huge
    for _, dock in pairs(DockingStations:GetChildren()) do
        local dist = (robot.PrimaryPart.Position - dock.Position).Magnitude
        if dist < minDist then
            minDist = dist
            nearestDock = dock
        end
    end
    return nearestDock
end

-- Production-ready docking logic
function dockRobot(robot)
    if not robot or not robot.PrimaryPart then return end
    local dock = findNearestDock(robot)
    if not dock then
        warn("No docking station found for robot " .. robot.Name)
        return
    end

    -- Move robot to dock
    robot:SetPrimaryPartCFrame(dock.CFrame + Vector3.new(0, 1, 0))
    -- Set status attribute
    robot:SetAttribute("Status", "Docked & Charging")

    -- Recharge battery after 5 seconds
    task.delay(5, function()
        local stats = require(game.ReplicatedStorage.RobotStats)[robot.Name]
        if stats then
            robot:SetAttribute("BatteryCurrent", stats.BatteryMax)
            robot:SetAttribute("Status", "Charged")
        end
    end)
end
