-- Script: DustSpawner
-- Spawns dust objects randomly in rooms
local Rooms = workspace.Rooms
local DustFolder = workspace.Dust
local DustTypes = {"Candy", "Crumbs", "Sand", "DustBall"}

local MAX_DUST = 50 -- Limit dust in game

function spawnDust()
    if #DustFolder:GetChildren() >= MAX_DUST then return end
    for _, room in pairs(Rooms:GetChildren()) do
        if math.random() < 0.2 then -- 20% chance per room per interval
            local dustType = DustTypes[math.random(1, #DustTypes)]
            local dust = Instance.new("Part")
            dust.Name = dustType
            dust.Size = Vector3.new(1,1,1)
            dust.Position = room.Position + Vector3.new(math.random(-10,10), 1, math.random(-10,10))
            dust.Anchored = true
            dust.BrickColor = BrickColor.Random()
            dust.Parent = DustFolder
        end
    end
end

while true do
    spawnDust()
    task.wait(5)
end
