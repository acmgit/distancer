# Distancer
Client-Side-Mod for Minetest to calculate and measure Distances.<br>
![Screenshot 1](screenshot.png)

## Description
This Mod helps you, to measure Distances in Minetest.<br>
Be carefull, this Version works only with Minetest Version 5.x.x.

## Commands
.dmark <> | Shows you the current stored Marker.<br>
.dmark -s | Set's the marker to your current Position.<br>
.dmark -m | Shows you the Distance between your current Position and the (valid) Marker.<br>
.dmark -p | Shows you the Vector of the Distance between your current Position and the (valid) Marker.<br>
.dmark -w X,Y,Z | Writes a manual given Position to the Marker. Example: .marker -w 50,-10,100 - Set's the Marker to the Position 50,-10,100.<br>

## HUD-Commands
.dhud on|off                | Turns all HUD's of Distancer on or off.<br>
.dhud_mapblock on|off       | Turns the HUD for the current Mapblock on or off.<br>
.dhud_measure on|off        | Turns the HUD for the Marker, Position and Distance on or off<br>
.dhud_waypoint on|off       | Turns the HUD for the Waypoint (Marker) on or off<br>
.dhud_waypoint -c <color>   | Changes the Color of the Waypoint to <color> or lists the available colors if empty or wrong
.dhud_set <>                | Show's the current Position of the HUD in the Chat.
.dhud_set -r                | Reset's the Position of the HUD to default.
.dhud_set -w .x,.y          | Changes the Position of the HUD on the Screen<br>
.dhud_speed <>              | Shows you the current Speed in Seconds the HUD will refresh.<br>
.dhud_speed Number          | Set's the current Refreshspeed of the HUD to Number Seconds.<br>

## Other Commands
.dshow_mapblock       | Shows you the Mapblocknumber of your current Position.<br>
.dwho                 | Lists the Names of the (online) Player.<br>

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

## install 
Move the folder to your clientmods directory of your minetest-folder.<br>
Then activate the mod in your mod.conf.<br>
