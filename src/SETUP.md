
# Production Setup Instructions

## Folder Structure
- Workspace/
  - Rooms/
  - Robots/
  - DockingStations/
  - Dust/
  - Props/
- ReplicatedStorage/
  - RobotStats.lua (ModuleScript)
  - RemoteEvents/
    - RobotControl (RemoteEvent)
    - DustCollected (RemoteEvent)
- ServerScriptService/
  - RobotAI.lua
  - DustSpawner.lua
  - DockingLogic.lua
- StarterGui/
  - RobotUI.md (ScreenGui setup instructions)
- StarterPlayerScripts/
  - RidingControls.lua
  - RobotUIController.lua

## Object Hierarchy & Setup
- **Rooms:** Create Models for each room, add floor Parts (Carpet/Wood), and props. Name rooms appropriately.
- **Docking Stations:** Place a Part in each room, name as Dock1, Dock2, etc. Position them for easy robot access.
- **Robots:** Create robot models with a PrimaryPart and a front-facing Sensor part for raycasting. Set attributes for BatteryCurrent, DustCollected, and Status.
- **Dust:** DustSpawner script will spawn dust in rooms. Use colored Parts or Meshes for realism.
- **UI:** Add ScreenGui named RobotUI with BatteryIndicator, DustCounter, and StatusPanel as TextLabels.

## Script Integration
- **RobotAI.lua:** Handles robot movement, obstacle avoidance, dust seeking, battery logic, and docking.
- **DockingLogic.lua:** Handles docking and battery recharge. Called from RobotAI.
- **DustSpawner.lua:** Spawns dust objects, limits total dust, randomizes type and color.
- **RidingControls.lua:** Allows player to ride robots, steer with WASD, and updates camera.
- **RobotUIController.lua:** Updates UI with robot stats and status in real time.

## UI Requirements
- Add a ScreenGui named RobotUI in StarterGui.
- Add TextLabels named BatteryIndicator, DustCounter, and StatusPanel.
- Ensure RobotUIController.lua updates these labels.

## Additional Notes
- All scripts are production ready and commented.
- Use RemoteEvents for client-server communication.
- Robots must have PrimaryPart and Sensor for correct AI operation.
- For detailed code or further instructions, see each script file or ask for specifics.