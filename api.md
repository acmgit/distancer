## Distancer API
<br>

### Add module:
You can easy extend the distancer with a new module. Take the pattern of the file cmd_.lua, fill out the help and save it under a new name "cmd_mymodulename.lua".
After then open the init.lua and add at the end of the code a line:

#### dofile("cmd_mymodulename.lua")
Now you have added a new Module, now you can fill out your module with your code.<br>

## API of Distancer
<br>
#### function distancer.add_hud_mapblock()
Starts the hud to display the mapblock.<br>
<br>

#### function distancer.add_hud_measure()
Starts the hud to display the distances.<br>
<br>

#### function distancer.add_hud_waypoint()
Starts the hud to disply the waypoint.<br>
<br>

#### function distancer.calc_distance_pos(Table pos_1, Table pos_2)
Returns the Distance as Table.<br>
<br>

#### function distancer.change_hud_position(Table screenposition)
Changes the position of the hud. Pay attention, these are screen-coordinates.<br>
<br>

#### function distancer.check(String cmd)
Checks if the command is valid and reports it in the chat.<br>
<br>

#### function distancer.check_hud_mapblock()
Returns true or false, if the hud is en- or disabled.<br>
<br>

#### function distancer.check_hud_measure()
Returns true or false, if the hud is en- or disabled.<br>
<br>

#### function distancer.check_hud_waypoint()
Returns true or false, if the hud is en- or disabled.<br>
<br>

#### function distancer.convert(table pos)
Converts the given position to #00.0<br>
<br>

#### function distancer.get_hud_position()
Write's the current position from the hud in chat.<br>
<br>

#### function distancer.get_mapblock()
Get's the number of the mapblock where you currently are.<br>
<br>

#### function distancer.hud_reset()
Reset's the current position of the hud to default x = 0.9, y = 0.7<br>
<br>

#### function distancer.hud_set_speed(float speed)
Set's the number of seconds between every update of the hud.<br>
A value of 0 will freeze the hud.<br>
<br>

#### function distancer.print(String text)
Write's a Text in the Chat.<br>
You can insert colors to your text too.<br>
<br>

#### function distancer.refresh_hud_mapblock()
Refreshs the hud. Turns it off and on.<br>
<br>

#### function distancer.refresh_hud_measure()
Refreshs the hud. Turns it off and on.<br>
<br>

#### function distancer.refresh_hud_waypoint()
Refreshs the hud. Turns it off and on.<br>
<br>

#### function distancer.register_help(Table entry)
Registers your Helptext and add it to the helpsystem.<br>
<br>

#### function distancer.remove_hud_mapblock()
Disables the hud for the mapblock. You can add it every time with distancer.add_hud_mapblock.<br>
<br>

#### function distancer.remove_hud_measure()
Disables the hud for distances. You can add it every time with distancer.add_hud_measure.<br>
<br>

#### function distancer.remove_hud_waypoint()
Disables the hud for waypoints. you can add it every time with distancer.add_hud_waypoint.<br>
<br>

#### function distancer.safe_dead()
Function to safe the your last position of dead in the waypoint.<br>
If there is already a position, the function safe's the position in distancer.old_marker.<br>
<br>

#### function distancer.show_version()
Prints the current version of distancer in the console.<br>
<br>

#### function distancer.update_hud()
Updates the HUD of distancer.<br>
<br>
<br>

## Tables of distancer
<br>

### Table position
position.x = value<br>
position.y = value<br>
position.z = value<br>
<br>

### Table help-entry
help.Name = String. Name and command of the Module.<br>
help.Usage = String. Short description of the command only.<br>
help.Description = String. Description of the fully command.<br>
help.Parameter = String. Has the command parameter? no, then "", yes, insert your parameters.<br>

### Table screenposition
position.x = value<br>
position.y = value<br>
<br>
<br>

## Colors of distancer
<br>
Distancer has colors for the chat definied, which you can use, for example:<br>
"This is a" .. distancer.green .. " green " .. distancer.white .. "Color."<br>
Following Colors are available:
<br>


|Color                |
|---------------------|
|distancer.black      |
|distancer.blue       |
|distancer.green      |
|distancer.grey       |
|distancer.light_blue |
|distancer.light_green|
|distancer.light_red  |
|distancer.orange     |
|distancer.pink       |
|distancer.purple     |
|distancer.red        |
|distancer.yellow     |
|distancer.white      |

<br>
<br>

### The hud has the same colors definied, but:
<br>

| HUD Color                       |
|---------------------------------|
|distancer.hud_color["black"]     |
|distancer.hud_color["blue"]      |
|distancer.hud_color["green"]     |
|distancer.hud_color["grey"]      |
|distancer.hud_color["lightblue"] |
|distancer.hud_color["lightgreen"]|
|distancer.hud_color["lightred"]  |
|distancer.hud_color["orange"]    |
|distancer.hud_color["pink"]      |
|distancer.hud_color["purple"]    |
|distancer.hud_color["red"]       |
|distancer.hud_color["yellow"]    |
|distancer.hud_color["white"]     |

<br>
<br>

## Variables of distancer:
<br>

#### distancer.marker
Position<br>
Waypoint of the distancer. NIL = no waypoint.<br>

#### distancer.modname
String<br>
Name of the distancer.<br>

#### distancer.old_marker
Postion<br>
Saved Waypoint. Used by distancer.safe_dead().<br>

#### distancer.revision
Integer<br>
Revision of the distancer.<br>

#### distancer.safe_dead_state
Boolean<br>
True or False. True, the distancer stores the position of your dead automatically.<br>

#### distancer.speed
Float<br>
Seconds to wait between every update.<br>

#### distancer.version
Integer<br>
Version of the distancer.<br>

## Mod-Channels in distancer:
<br>
Distancer is prepared to use mod-channels to communicate with other mods.<br>
But the this are a feature for future use.<br>
<br>
