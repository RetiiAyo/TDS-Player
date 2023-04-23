# TDS-Player
open source Roblox Tower Defense Simulator script (BETA)

# Recorder

```lua
getgenv().Settings = {
    Logs = "WEBHOOK HERE (NOT NEEDED)",
    Multiplayer = {
        Enabled = false, -- IN WORKS, DON'T ENABLE
        Players = {}
    },
}
getgenv().FileName = "Recording"

loadstring(game:HttpGet("https://raw.githubusercontent.com/RetiiAyo/TDS-Player/main/recorder.lua"))()
```

# Player

```lua
-- Recorder generates a script that you can execute. Player will do all the actions you did for you.
-- Player includes: Auto-join, Auto-equip, Auto-leave when player joins elevator and Auto-leave
```
