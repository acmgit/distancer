# Distancer
Client-Side-Mod for Minetest to calculate and measure Distances.<br>
![Screenshot 1](screenshot.png)
<br>
## Description
This Mod helps you, to measure Distances in Minetest.<br>
Be carefull, this Version works only with Minetest Version 5.x.x.
<br>
Fully revised, more modularity and using of command-pattern.
<br>
## General Commands
.dis help                                 - Shows you a help of the commands.<br>
.dis who                                  - Shows you, who is online.<br>
.dis change_safe_dead <> | on | off       - Turns the automatic position-store of your dead on or off.<br>
.dis restore_marker                       - Swaps the old waypoint with the deadposition.<br>
<br>
## Marker Commands
.dis mark <> | -s | -m | -p | -w X,Y,Z<br>
.dis mark -s                              - Set's the marker to your current position.<br>
.dis mark -m                              - Shows you the distance between the marker anc your current position.<br>
.dis mark -p                              - Shows you the distance between the marker anc your current position as vector.<br>
.dis mark -w X,Y,Z                        - Set's the marker to the given position.<br>
<br>
## HUD Commands
.dis hud on | off                         - Turns all huds of distancer on or off.<br>
.dis hud_mapblock on | off                - Turns the hud for the mapblock on or off.<br>
.dis hud_measure on | off                 - Turns the hud to measure distances on or off.<br>
.dis hud_waypoint on | off                - Turns the hud for the waypoint on or off.<br>
<br>
.dis hud_set <> | -r | -w .X,.Y           - Commands for the hud-position.<br>
.dis hud_set <>                           - Shows the current hud-position.<br>
.dis hud_set -r                           - Resets the position of the hud to default.<br>
.dis hud_set -w 0.X,0.Y                   - Changes the position in percentage of the HUD to 0.X,0.Y.<br>
<br>
.dis hud_speed <> | -s Seconds            - Commands for the hud-update-speed.<br>
.dis hud_speed <>                         - Shows the current update-speed in seconds.<br>
.dis hud_speed -s Seconds                 - Set's the current update-delay to seconds.<br>
<br>
## for Modwriter
With the Version 2.7 or higher, the Distancer has a API for other mods.<br>

### Var:
dst.ver                 | Version Number of the loaded Distancer.<br>
dst.rev                 | Revision Number of the loaded Distancer.<br>
dst.name                | Name of the Mod.<br>

### API:
dst.send_pos(name, position)   | name = playername, position = string like "0,0,0". Set's the Marker to the Position "x,y,z".<br>

## License
GPL 3.0 by A.C.M.<br>

## depends
nothing<br>
<br>
## install 
Move the folder to your clientmods directory of your minetest-folder.<br>
Then activate the mod in your mods.conf.<br>
Important: Not the mod.conf inside the mod!!<br>
<br>
<br>
## Documentation for Developer
[api.md](api.md)

## Documentation as plain Text
[api.txt](api.txt)
<br>
