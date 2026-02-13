-- Bootstrap.lua
-- Creates minimal workspace objects (Rooms, Robots, Docks, Dust folder) and RemoteEvents
local Workspace = workspace
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Create folders/models if missing
local function ensureFolder(parent, name, className)
    local obj = parent:FindFirstChild(name)
    if obj then return obj end
    className = className or "Folder"
    local newObj = Instance.new(className)
    newObj.Name = name
    newObj.Parent = parent
    return newObj
end

local Rooms = ensureFolder(Workspace, "Rooms", "Folder")
local Robots = ensureFolder(Workspace, "Robots", "Folder")
local DockingStations = ensureFolder(Workspace, "DockingStations", "Folder")
local Dust = ensureFolder(Workspace, "Dust", "Folder")
local Props = ensureFolder(Workspace, "Props", "Folder")

-- Create ReplicatedStorage/RemoteEvents if missing
local remoteFolder = ReplicatedStorage:FindFirstChild("RemoteEvents") or Instance.new("Folder")
remoteFolder.Name = "RemoteEvents"
remoteFolder.Parent = ReplicatedStorage

local function ensureRemote(name)
    if remoteFolder:FindFirstChild(name) then return end
    local ev = Instance.new("RemoteEvent")
    ev.Name = name
    ev.Parent = remoteFolder
end

ensureRemote("RobotControl")
ensureRemote("DustCollected")

-- Create a few sample rooms (simple anchored Parts)
if #Rooms:GetChildren() == 0 then
    for i = 1, 4 do
        local room = Instance.new("Part")
        room.Name = "Room" .. i
        room.Size = Vector3.new(50, 1, 50)
        room.Anchored = true
        room.Position = Vector3.new((i-1) * 60, 0, 0)
        room.Parent = Rooms
    end
end

-- Create a sample docking station per room
if #DockingStations:GetChildren() == 0 then
    for i, room in pairs(Rooms:GetChildren()) do
        local dock = Instance.new("Part")
        dock.Name = "Dock" .. i
        dock.Size = Vector3.new(4,1,4)
        dock.Anchored = true
        dock.Position = room.Position + Vector3.new(0,2,0)
        dock.BrickColor = BrickColor.new("Bright green")
        dock.Parent = DockingStations
    end
end

-- Create sample Robots if none exist
if #Robots:GetChildren() == 0 then
    for i = 1, 3 do
        local model = Instance.new("Model")
        model.Name = "Robot" .. i

        local body = Instance.new("Part")
        body.Name = "Body"
        body.Size = Vector3.new(2,1,2)
        body.Position = Vector3.new((i-1)*5, 3, 0)
        body.Anchored = false
        body.Parent = model

        local sensor = Instance.new("Part")
        sensor.Name = "Sensor"
        sensor.Size = Vector3.new(0.2,0.2,0.2)
        sensor.Position = body.Position + Vector3.new(0,0,2)
        sensor.Anchored = false
        sensor.Parent = model

        model.PrimaryPart = body
        model.Parent = Robots

        -- Attributes
        model:SetAttribute("BatteryCurrent", 100)
        model:SetAttribute("DustCollected", 0)
        model:SetAttribute("Status", "Idle")
    end
end

print("Bootstrap complete: Rooms, Robots, DockingStations, Dust, RemoteEvents ensured.")
