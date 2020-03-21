--[[
   ****************************************************************
   *******                     Distancer                     ******
   *******    A CS-Mod to measure Distances in Minetest      ******
   *******                  License: GPL 3.0                 ******
   *******                     by A.C.M.                     ******
   ****************************************************************
--]]

dst = {}

distancer = {}

distancer.version = 3
distancer.revision = 0
distancer.modname = "Distancer"

distancer.marker = nil
distancer.old_marker = nil
distancer.speed = .5 -- Update every distancer.speed seconds
distancer.safe_dead_state = true

-- Colors for Chat
distancer.green = minetest.get_color_escape_sequence('#00FF00')
distancer.red = minetest.get_color_escape_sequence('#FF0000')
distancer.orange = minetest.get_color_escape_sequence('#FF6700')
distancer.blue = minetest.get_color_escape_sequence('#0000FF')
distancer.yellow = minetest.get_color_escape_sequence('#FFFF00')
distancer.purple = minetest.get_color_escape_sequence('#FF00FF')
distancer.pink = minetest.get_color_escape_sequence('#FFAAFF')
distancer.white = minetest.get_color_escape_sequence('#FFFFFF')
distancer.black = minetest.get_color_escape_sequence('#000000')
distancer.grey = minetest.get_color_escape_sequence('#888888')
distancer.light_blue = minetest.get_color_escape_sequence('#8888FF')
distancer.light_green = minetest.get_color_escape_sequence('#88FF88')
distancer.light_red = minetest.get_color_escape_sequence('#FF8888')

dst.ver = distancer.version
dst.rev = distancer.revision
dst.mname = distancer.modname

dst.channelname = "distancer"

distancer.hud_color = {
                        ["green"]        = 0x00FF00,
                        ["red"]          = 0xFF0000,
                        ["orange"]       = 0xFF6700,
                        ["blue"]         = 0x0000FF,
                        ["yellow"]       = 0xFFFF00,
                        ["purple"]       = 0xFF00FF,
                        ["pink"]         = 0xFFAAFF,
                        ["white"]        = 0xFFFFFF,
                        ["black"]        = 0x000000,
                        ["grey"]         = 0x888888,
                        ["lightblue"]    = 0x8888FF,
                        ["lightgreen"]   = 0x88FF88,
                        ["lightred"]     = 0xFF8888,
                    }

distancer.hud_waypoint_color = distancer.hud_color["red"]

-- Position of the Hud
distancer.hud_x = 0.9
distancer.hud_y = 0.7

-- Values on the Hud
distancer.hud_mapblock_label = nil
distancer.hud_mapblock_value = nil
distancer.hud_distance_label = nil
distancer.hud_marker = nil
distancer.hud_position = nil
distancer.hud_distance = nil
distancer.hud_waypoint_value = nil
distancer.hud_waypoint_name = ""

local pos_to_string = minetest.pos_to_string
local string_to_pos = minetest.string_to_pos

--[[
   ****************************************************************
   *******        Functions for Distancer                    ******
   ****************************************************************
--]]


--[[
   ****************************************************************
   *******   Function calc_distance(position 1, position 2)  ******
   ****************************************************************
--]]
function distancer.calc_distance_pos(pos_1, pos_2)
    local distance = {}

    if(pos_1 ~= nil and pos_2 ~= nil) then
        distance.x = pos_1.x - pos_2.x
        distance.y = pos_1.y - pos_2.y
        distance.z = pos_1.z - pos_2.z
        distance = distancer.convert_position(distance)

    end -- if(pos_1 ~= nil


    return distance

end -- function calc_distance_pos

--[[
   ****************************************************************
   *******        Function split(parameter)                  ******
   ****************************************************************
    Split Command and Parameter and write it to a table
--]]
function distancer.split(parameter)
        local cmd = {}
        for word in string.gmatch(parameter, "[%w%-%:%.2f%_]+") do
            table.insert(cmd, word)

        end -- for word

        return cmd

end -- function distancer.split

--[[
   ****************************************************************
   *******        Function check(command)                    ******
   ****************************************************************
    Check if the command is valid
--]]
function distancer.check(cmd)

        if(distancer[cmd[1]] ~= nil) then
        -- Command is valid, execute it with parameter
           distancer[cmd[1]](cmd)

        else -- A command is given, but
        -- Command not found, report it.
            if(cmd[1] ~= nil) then
                distancer.print(distancer.red .. "Distancer: Unknown Command \"" ..
                                distancer.orange .. cmd[1] .. distancer.red .. "\".")

            else
                distancer["help"]()

            end -- if(cmd[1]

        end -- if(distancer[cmd[1

end -- function distancer.check(cmd

--[[
   ****************************************************************
   *******     Function display_chat_message(message)        ******
   ****************************************************************
]]--
local dprint = minetest.display_chat_message
function distancer.print(text)
    dprint(text)

end -- function distancer.print(

--[[
   ****************************************************************
   *******       Function convert_position(position)         ******
   ****************************************************************
]]--
function distancer.convert_position(pos)

    if(pos ~= nil) then

        pos.x = tonumber(string.format("%.1f",pos.x))
        pos.y = tonumber(string.format("%.1f",pos.y))
        pos.z = tonumber(string.format("%.1f",pos.z))
        return pos

    end -- if(distancer.marker ~= nil

    return nil

end -- function convert_position

--[[
   ****************************************************************
   *******         Function get_mapblock()                   ******
   ****************************************************************
]]--
function distancer.get_mapblock()
    local mypos = minetest.localplayer:get_pos()
    local x = math.floor(mypos.x+0.5)
    local y = math.floor(mypos.y+0.5)
    local z = math.floor(mypos.z+0.5)

    local pos_string = math.floor(x / 16) .. "." .. math.floor(y / 16) .. "." .. math.floor(z / 16)

    return pos_string

end -- distancer.get_mapblock

--[[
   ****************************************************************
   *******           Function safe_dead()                    ******
   ****************************************************************
    Safes the Position of the Player in case of death.
]]--
function distancer.safe_dead()
    local current_position

    current_position = minetest.localplayer:get_pos()
    current_position = distancer.convert_position(current_position)

    if(distancer.marker ~= nil) then
        distancer.old_marker = distancer.marker
        distancer.print(distancer.green .. "Old Markerposition saved.")

    end -- if(distancer.marker

    distancer.marker = current_position
    distancer.print(distancer.green .. "Your Position of dead is set to the marker.")

    if(distancer.check_hud_waypoint()) then
        distancer.set_hud_waypoint("off")
        distancer.set_hud_waypoint("on")

    end -- if(distancer.check_hud_waypoint

end -- distancer.safe_dead(

--[[
   ****************************************************************
   *******         Function show_version()                   ******
   ****************************************************************
]]--
function distancer.show_version()
    print("[CSM-MOD]" .. distancer.modname .. " v " .. distancer.version .. "." .. distancer.revision .. " loaded. \n")

end -- distancer.version

--[[
   ****************************************************************
   *******             Global API for Distancer              ******
   ****************************************************************
--]]

--[[

    dst.send_pos(<string>, <string>)
    dst.send_pos("playername", "x,y,z")

    for example:
    dst.send_pos("singleplayer", "5,10,20") -- A Mod has set the Marker to Position x = 5, y = 10, z = 20

--]]

function dst.send_pos(name, coord)
    if(type(name) == "string") then
        local myname = minetest.localplayer:get_name()

        if(name == myname) then

            if(type(coord) == "string") then
                distancer.marker = string_to_pos(coord)
                distancer.dmark("-w " .. coord)
                distancer.print(distancer.green .. "Prospector set the Marker to " ..
                distancer.orange .. coord .. distancer.green .. " .\n")

            else
                distancer.print(distancer.yellow .. "Wrong or no Coordinates given.\n")

            end -- if(type(coord)

        end -- if(name == myname

    else
        distancer.print(distancer.yellow .. "No Playername given.\n")

    end -- if(type(name)

end -- function dst.send_pos

--[[
   ****************************************************************
   *******     Functions for MOD-Channel of Distancer        ******
   ****************************************************************
--]]

function distancer.handle_channel_event(channel, msg)
    local report
    if(msg >= 0) then
        if(msg == 0) then
            report = distancer.orange .. " joined with success.\n"

        elseif(msg == 1) then
            report = distancer.red .. " join failed.\n"

        elseif(msg == 2) then
            report = distancer.orange .. " leave with success.\n"

        elseif(msg == 3) then
            report = distancer.red .. " leave failed.\n"

        elseif(msg == 4) then
            report = distancer.orange .. " Event on another Channel.\n"

        elseif(msg == 5) then
            report = distancer.orange .. " state changed.\n"

        else
            report = distancer.red .. " unknown Event.\n"

        end
        distancer.print(distancer.green .. "[Distancer] Channel: " .. distancer.yellow .. channel ..
        distancer.green .. ": " .. distancer.orange .. report)

      else
        distancer.print(distancer.orange .. "[Distancer]: Illegal Message received on " ..
        distancer.yellow .. channel .. distancer.red .. ": " .. msg)

    end -- if(msg >= 0

end -- function prospector.handle_channel_event(

function distancer.handle_message(channel, sender, message)
    if(channel == dst.distancer_channelname) then
      distancer.print(distancer.green .. "Message from " .. distancer.orange .. sender ..
      distancer.green .. " received.\n")
      distancer.print(distancer.green .. "Message: " .. distancer.orange .. message .. distancer.green .. " .\n")

    end -- if(channelname ==

end -- distancer.handle_message


--[[
   ****************************************************************
   *******           Function for the HUD                    ******
   ****************************************************************
]]--


--[[
   ****************************************************************
   *******          Function update_hud()                    ******
   ****************************************************************
]]--
function distancer.update_hud()

    if(distancer.hud_mapblock_value ~= false) then

        if(distancer.hud_mapblock_value ~= nil) then
            minetest.localplayer:hud_change(distancer.hud_mapblock_value, "text", distancer.get_mapblock())

        end -- if(distancer.hud_mapblock_value ~= nil

    end -- if(distancer_hud_mapblock

    if(distancer.hud_marker ~= nil and distancer.hud_position ~= nil and distancer.hud_distance ~= nil) then
        local current_position = minetest.localplayer:get_pos()
        current_position = distancer.convert_position(current_position)
        minetest.localplayer:hud_change(distancer.hud_position, "text", pos_to_string(current_position))

        if(distancer.marker ~= nil) then
            minetest.localplayer:hud_change(distancer.hud_marker, "text", pos_to_string(distancer.marker))
            minetest.localplayer:hud_change(distancer.hud_distance, "text",
            pos_to_string(distancer.calc_distance_pos(distancer.marker, current_position)))

        end -- if(distancer.hud_marker ~= nil

    end -- if(hud_marker and hud_position and hud_distance

    if(distancer.hud_waypoint_value ~= nil) then
        minetest.localplayer:hud_change(distancer.hud_waypoint_value, "world_pos", distancer.marker)

    end -- if(distancer.hud_waypoint_value ~= nil

    if(distancer.speed > 0) then
        minetest.after(distancer.speed, function()
            distancer.update_hud()

        end) -- minetest.after(

    end -- if(distancer.speed

end -- distancer.update_hud

--[[
   ****************************************************************
   *******         Function get_hud_position()               ******
   ****************************************************************
]]--
function distancer.get_hud_position()
    distancer.print(distancer.green .. "Current Position of the HUD is:\n" .. distancer.orange .. " X = " ..
    distancer.hud_x * 100 .. "% of Screen.\n" .. distancer.orange .. " Y = " ..
    distancer.hud_y * 100 .. "% of Screen.\n")

end -- distancer.get_hud_position

--[[
   ****************************************************************
   *******        Function add_hud_mapblock()                ******
   ****************************************************************
]]--
function distancer.add_hud_mapblock()

    local idx = 0 -- Starting Hud

    distancer.hud_mapblock_label = minetest.localplayer:hud_add(
    {
        name = "Mapblock",    -- default ""
        hud_elem_type = "text",
        number = 0x00FF00, -- Color of the Text
        text = "Current Mapblock",
        position = {x = distancer.hud_x, y = distancer.hud_y+idx},
        direction = 1

    }) -- minetest.localplayer:hud_add

    idx = idx + .02 -- Next Hud-Element
    distancer.hud_mapblock_value = minetest.localplayer:hud_add(
    {
        name = "Mapblock_Value",    -- default ""
        hud_elem_type = "text",
        number = 0xFF6700, -- Color of the Text
        text = "(0.0.0)",
        position = {x = distancer.hud_x, y = distancer.hud_y+idx},
        direction = 1

    }) -- minetest.localplayer:hud_add

end -- function add_hud_mapblock()

--[[
   ****************************************************************
   *******        Function add_hud_measure()                 ******
   ****************************************************************
]]--
function distancer.add_hud_measure()

    local idx = .04
    if(minetest.localplayer == nil) then
        minetest.localplayer = minetest.localplayer

    end -- if(minetest.localplayer == nil

    distancer.hud_distance_label = minetest.localplayer:hud_add(
    {
        name = "Mesure",    -- default ""
        hud_elem_type = "text",
        number = 0x00FF00, -- Color of the Text
        text = "Marker - Position - Distance",
        position = {x = distancer.hud_x, y = distancer.hud_y+idx},
        direction = 1

    }) -- minetest.localplayer:hud_add

    idx = idx + .02
    distancer.hud_marker = minetest.localplayer:hud_add(
    {
        name = "Marker_Value",    -- default ""
        hud_elem_type = "text",
        number = 0xFF6700, -- Color of the Text
        text = "(0.0.0)",
        position = {x = distancer.hud_x, y = distancer.hud_y+idx},
        direction = 1

    }) -- minetest.localplayer:hud_add

    idx = idx + .02
    distancer.hud_position = minetest.localplayer:hud_add(
    {
        name = "Position_Value",    -- default ""
        hud_elem_type = "text",
        number = 0xFFFF00, -- Color of the Text
        text = "(0.0.0)",
        position = {x = distancer.hud_x, y = distancer.hud_y+idx},
        direction = 1

    }) -- minetest.localplayer:hud_add

    idx = idx + .02
    distancer.hud_distance = minetest.localplayer:hud_add(
    {
        name = "Distance_Value",    -- default ""
        hud_elem_type = "text",
        number = 0xFFFFFF, -- Color of the Text
        text = "(0.0.0)",
        position = {x = distancer.hud_x, y = distancer.hud_y+idx},
        direction = 1

    }) -- minetest.localplayer:hud_add

end -- distancer.add_hud_measure()

--[[
   ****************************************************************
   *******       Function add_hud_waypoint()                 ******
   ****************************************************************
]]--
function distancer.add_hud_waypoint()

    --local idx = idx + .12
    if(distancer.marker == nil) then
        distancer.hud_waypoint_name = "0,0,0"

    else
        distancer.hud_waypoint_name = pos_to_string(distancer.marker)

    end -- if(distancer.marker == nil

    distancer.hud_waypoint_value = minetest.localplayer:hud_add(
    {
        name = distancer.hud_waypoint_name,
        hud_elem_type = "waypoint",
        number = distancer.hud_waypoint_color,
        text = " Meter",
        world_pos = {x=0, y=0, z=0},
    }) -- minetest.localplayer:hud_add

end -- distancer.add_hud_waypoint()

--[[
   ****************************************************************
   *******       Function remove_hud_mapblock()              ******
   ****************************************************************
]]--
function distancer.remove_hud_mapblock()
    minetest.localplayer:hud_remove(distancer.hud_mapblock_label)
    minetest.localplayer:hud_remove(distancer.hud_mapblock_value)
    distancer.hud_mapblock_label = nil
    distancer.hud_mapblock_value = nil

end -- function distancer.remove_hud_mapblock

--[[
   ****************************************************************
   *******        Function remove_hud_measure()              ******
   ****************************************************************
]]--
function distancer.remove_hud_measure()
    minetest.localplayer:hud_remove(distancer.hud_distance_label)
    minetest.localplayer:hud_remove(distancer.hud_marker)
    minetest.localplayer:hud_remove(distancer.hud_position)
    minetest.localplayer:hud_remove(distancer.hud_distance)
    distancer.hud_distance_label = nil
    distancer.hud_marker = nil
    distancer.hud_position = nil
    distancer.hud_distance = nil

end -- function distancer.remove_hud_measure

--[[
   ****************************************************************
   *******       Function remove_hud_waypoint()              ******
   ****************************************************************
]]--
function distancer.remove_hud_waypoint()
    minetest.localplayer:hud_remove(distancer.hud_waypoint_value)
    distancer.hud_waypoint_value = nil

end -- function distancer.remove_hud_waypoint

--[[
   ****************************************************************
   *******        Function check_hud_mapblock()              ******
   ****************************************************************
]]--
function distancer.check_hud_mapblock()
    local on = false

    if(distancer.hud_mapblock_label ~= nil and distancer.hud_mapblock_value ~= nil) then
            on = true

    end -- if(distancer.hud_mapblock_label

    return on

end -- distancer.check_hud_mapblock

--[[
   ****************************************************************
   *******         Function check_hud_measure()              ******
   ****************************************************************
]]--
function distancer.check_hud_measure()
    local on = false

    if(distancer.hud_distance_label ~= nil and
        distancer.hud_marker ~= nil and
        distancer.hud_position ~= nil and
        distancer.hud_distance ~= nil)
    then
        on = true

    end -- if(distancer.hud_mapblock_label

    return on

end -- distancer.check_hud_measure()

--[[
   ****************************************************************
   *******        Function check_hud_waypoint()              ******
   ****************************************************************
]]--
function distancer.check_hud_waypoint()
    local on = false

    if(distancer.hud_waypoint_value ~= nil) then
        on = true

    end -- if(distancer.hud_waypoint_value

    return on

end -- function distancer.check_hud_waypoint

--[[
   ****************************************************************
   *******        Function refresh_hud_mapblock()            ******
   ****************************************************************
]]--
function distancer.refresh_hud_mapblock()
    if(distancer.check_hud_mapblock()) then
            distancer["hud_mapblock"]({"hud_mapblock","off"})
            distancer["hud_mapblock"]({"hud_mapblock","on"})

    end -- if(distancer.check_hud_mapblock()

end -- distancer.change_hud_mapblock()

--[[
   ****************************************************************
   *******        Function refresh_hud_measure()             ******
   ****************************************************************
]]--
function distancer.refresh_hud_measure()
    if(distancer.check_hud_measure()) then
            distancer["hud_measure"]({"hud_measure", "off"})
            distancer["hud_measure"]({"hud_measure", "on"})

    end -- if(distancer.check_hud_measure()

end -- distancer.change_hud_measure()

--[[
   ****************************************************************
   *******        Function refresh_hud_waypoint()            ******
   ****************************************************************
]]--
function distancer.refresh_hud_waypoint()
    if(distancer.check_hud_waypoint()) then
            distancer["hud_waypoint"]({"hud_waypoint", "off"})
            distancer["hud_waypoint"]({"hud_waypoint", "on"})
            --distancer.set_hud_waypoint("off")
            --distancer.set_hud_waypoint("on")

    end -- if(distancer.check_hud_mapblock()

end -- distancer.change_hud_mapblock()

--[[
   ****************************************************************
   *******      Function change_hud_position(Positioni)      ******
   ****************************************************************
]]--
function distancer.change_hud_position(position)
    local x = position.x
    local y = position.y
    local mapblock = distancer.check_hud_mapblock()
    local measure = distancer.check_hud_measure()

    if(mapblock) then -- is the Hud on?
        distancer.remove_hud_mapblock()

    end -- if(distancer.hud_mapblock_label

    if(measure) then -- is the Hud on?
        distancer.remove_hud_measure()

    end -- if(distancer.hud_mapblock_label

    if(x >= 100 or y >= 100) then
        return false

    elseif( x >=1 or y >= 1) then -- Make float
        position.x = position.x / 100
        position.y = position.y / 100

    end -- if(x >= 100

    -- Convert to 2 Digits after .
    position.x = tonumber(string.format("%.2f",position.x))
    position.y = tonumber(string.format("%.2f",position.y))

    if(position.x > 0) then
        distancer.hud_x = position.x
    end

    if(position.y > 0) then
        distancer.hud_y = position.y
    end

    distancer.print(distancer.green .. "Position of HUD changed to: "..
    distancer.orange .. "X = " .. position.x .. " Y = " .. position.y .. distancer.green .. ".")

    if(mapblock) then
        distancer.add_hud_mapblock()
    end

    if(measure) then
        distancer.add_hud_measure()
    end

    return true

end -- function distancer.change_hud_position

--[[
   ****************************************************************
   *******            Function hud_reset()                   ******
   ****************************************************************
    Resets the Position of the Hud to the default.
]]--
function distancer.hud_reset()
    local hud_mp = distancer.check_hud_mapblock()
    local hud_ms = distancer.check_hud_measure()

    -- Turns the HUD off
    if(hud_mp) then
        distancer.remove_hud_mapblock()
    end

    if(hud_ms) then
        distancer.remove_hud_measure()
    end

    -- Resets the Position
    distancer.hud_x = 0.9
    distancer.hud_y = 0.7

    -- Turns the HUD on, if they WAS on.
    if(hud_mp) then
        distancer.add_hud_mapblock()
    end

    if(hud_ms) then
        distancer.add_hud_measure()
    end

end -- function distancer.hud_reset

--[[
   ****************************************************************
   *******      Function hud_set_speed(float Seconds)        ******
   ****************************************************************
]]--
function distancer.hud_set_speed(speed)
    if(speed >= 0 and speed ~= nil) then
        distancer.speed = speed
        distancer.update_hud()
        distancer.print(distancer.green .. "Distancer-HUD will now update all " ..
        distancer.orange .. distancer.speed .. distancer.green .. " seconds.\n")

    else
        distancer.speed = 0
        distancer.print(distancer.green .. "Distancer-HUD will now not updated.\n")

    end -- if(speed >= 0

end -- distancer.hud_speed(

--[[
   ****************************************************************
   *******        Registered Chatcommands                    ******
   ****************************************************************
--]]

minetest.register_chatcommand("dis",{
    param = "<command> <parameter>",
    description = "Gives the Distancer a command with or without Parameter.\n",
    func = function(cmd)
                if(cmd.type == "string") then
                    cmd = cmd:lower()
                end
                local command = distancer.split(cmd)
                distancer.check(command)

            end -- function

}) -- minetest.register_chatcommand("dis


--[[
   ****************************************************************
   *******        Main for Distancer                         ******
   ****************************************************************
--]]

minetest.after(distancer.speed, function()
    distancer.update_hud()

end) -- minetest.after(

minetest.register_on_death(function()
    if(distancer.safe_dead_state) then
        distancer.safe_dead()

    end

end) -- minetest.register_on_death(

-- Join to shared Modchannel
dst.channel = minetest.mod_channel_join(dst.channelname)

minetest.register_on_modchannel_signal(function(channel, signal)
            distancer.handle_channel_event(channel, signal)

end) -- minetest.register_on_modchannel_signal(


minetest.register_on_modchannel_message(function(channel, sender, message)
        distancer.handle_message(channel, sender, message)

end) -- minetest.register_on_mod_channel_message

distancer.show_version()

dofile("distancer:cmd_help.lua")
dofile("distancer:cmd_who.lua")
dofile("distancer:cmd_show_mapblock.lua")
dofile("distancer:cmd_change_safe_dead.lua")
dofile("distancer:cmd_restore_marker.lua")
dofile("distancer:cmd_mark.lua")
dofile("distancer:cmd_hud_mapblock.lua")
dofile("distancer:cmd_hud_measure.lua")
dofile("distancer:cmd_hud_waypoint.lua")
dofile("distancer:cmd_hud_set.lua")
dofile("distancer:cmd_hud_speed.lua")
dofile("distancer:cmd_hud.lua")
