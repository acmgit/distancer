# Distancer
Client-Side-Mod for Minetest to calculate and measure Distances.<br>

## Description
This Mod helps you, to measure Distances in Minetest.<br>
Be carefull, this Version works only with Minetest Version 5.x.x.

## Commands
.marker    | Shows you the current stored Marker.<br>
.marker -s | Set's the marker to your current Position.<br>
.marker -m | Shows you the Distance between your current Position and the (valid) Marker.<br>
.marker -p | Shows you the Vector of the Distance between your current Position and the (valid) Marker.<br>
.marker -w X,Y,Z | Writes a manual given Position to the Marker. Example: .marker -w 50,-10,100 - Set's the Marker to the Position 50,-10,100.<br>

## HUD-Commands
.distancer_hud_mapblock on|off | Turns the HUD for the current Mapblock on or off.<br>
.distancer_hud_measure on|off  | Turns the HUD for the Marker, Position and Distance on or off<br>

## Other Commands
.show_mapblock | Shows you the Mapblocknumber of your current Position.<br>
.who_is_online | Lists the Names of the (online) Player.<br>
.distancer_version | Shows you the Version of the Mod.<br>

## License
GPL 3.0 by A.C.M.<br>

## depends
nothing<br>

## install 
Move the folder to your clientmods directory of your minetest-folder.<br>
Then activate the mod in your mod.conf.<br>
