# RobotUI Setup

Add a ScreenGui named `RobotUI` in StarterGui. Create Frames for:
- BatteryIndicator
- DustCounter
- StatusPanel

Each Frame should display relevant info:
- BatteryIndicator: Robot battery %
- DustCounter: Dust collected
- StatusPanel: ON/OFF, Battery %, Returning to dock, Docked & charging, Dust capacity

Scripts in StarterPlayerScripts/RobotUIController.lua will update these elements.