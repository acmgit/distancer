--[[
   ****************************************************************
   *******                     Distancer                     ******
   *******    A CS-Mod to measure Distances in Minetest      ******
   *******                  License: GPL 3.0                 ******
   *******                     by A.C.M.                     ******
   ****************************************************************
--]]

local distancer = {}

distancer.version = 2
distancer.revision = 2
distancer.modname = "Distancer"

distancer.you = nil -- Player
distancer.marker = nil
distancer.speed = .5 -- Update every distancer.speed seconds

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

-- Position of the Hud
distancer.hud_x = 0.9
distancer.hud_y = 0.7

-- Values on the Hud
distancer.hud_mapblock_label = nil
distancer.hud_mapblock = nil
distancer.hud_distance_label = nil
distancer.hud_marker = nil
distancer.hud_position = nil
distancer.hud_distance = nil

--[[
   ****************************************************************
   *******        Functions for Distancer                    ******
   ****************************************************************
--]]


function distancer.calc_distance()
    return math.floor(vector.distance(distancer.you:get_pos(), minetest.string_to_pos(distancer.last_pos)))

end -- function calc_distance

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

function distancer.split(parameter)
        local cmd = {}
        for word in string.gmatch(parameter, "[%w%-%:%.2f]+") do
            table.insert(cmd, word)
            
        end -- for word
        
        return cmd
        
end -- function distancer.split

function distancer.print(text)
    minetest.display_chat_message(text)
    
end -- function distancer.print(

function distancer.convert_position(pos)
    
    if(pos ~= nil) then

        pos.x = tonumber(string.format("%.1f",pos.x))
        pos.y = tonumber(string.format("%.1f",pos.y))
        pos.z = tonumber(string.format("%.1f",pos.z))
        return pos
        
    end -- if(distancer.marker ~= nil
    
    return nil
    
end -- function convert_position
    
function distancer.get_mapblock()

    local pos_string = nil
    
    local mypos = distancer.you:get_pos()
    local x = math.floor(mypos.x+0.5)
    local y = math.floor(mypos.y+0.5)
    local z = math.floor(mypos.z+0.5)
    
    local pos_string = math.floor(x / 16) .. "." .. math.floor(y / 16) .. "." .. math.floor(z / 16)

    return pos_string
    
end -- distancer.get_mapblock

function distancer.get_hud_position()
    distancer.print(distancer.green .. "Current Position of the HUD is:\n" .. distancer.orange .. " X = " .. distancer.hud_x * 100 .. "% of Screen.\n" .. distancer.orange .. " Y = " .. distancer.hud_y * 100 .. "% of Screen.\n")

end -- distancer.get_hud_position

--[[
   ****************************************************************
   *******        Functions for HUD of Distancer             ******
   ****************************************************************
--]]

function distancer.update_hud()

    if(distancer.hud_mapblock ~= false) then
       
        if(distancer.hud_mapblock ~= nil) then
            distancer.you:hud_change(distancer.hud_mapblock, "text", distancer.get_mapblock())
        
        end -- if(distancer.hud_mapblock ~= nil
      
    end -- if(distancer_hud_mapblock 
      
    if(distancer.hud_marker ~= nil and distancer.hud_position ~= nil and distancer.hud_distance ~= nil) then
        local current_position = distancer.you:get_pos()
        current_position = distancer.convert_position(current_position)        
        distancer.you:hud_change(distancer.hud_position, "text", minetest.pos_to_string(current_position))

        if(distancer.marker ~= nil) then
            distancer.you:hud_change(distancer.hud_marker, "text", minetest.pos_to_string(distancer.marker))
            distancer.you:hud_change(distancer.hud_distance, "text", minetest.pos_to_string(distancer.calc_distance_pos(distancer.marker, current_position)))
        
        end -- if(distancer.hud_marker ~= nil
    
    end -- if(hud_marker and hud_position and hud_distance

    if(distancer.speed > 0) then
        minetest.after(distancer.speed, function()
            distancer.update_hud()
              
        end) -- minetest.after(

    end -- if(distancer.speed
        
end -- distancer.update_hud

function distancer.add_hud_mapblock()

    local idx = 0 -- Starting Hud
    distancer.hud_mapblock_label = distancer.you:hud_add(
    {
        name = "Mapblock",    -- default ""
        hud_elem_type = "text",
        number = 0x00FF00, -- Color of the Text
        text = "Current Mapblock",
        position = {x = distancer.hud_x, y = distancer.hud_y+idx},
        direction = 1
 
    }) -- distancer.you:hud_add

    idx = idx + .02 -- Next Hud-Element
    distancer.hud_mapblock = distancer.you:hud_add(
    {
        name = "Mapblock_Value",    -- default ""
        hud_elem_type = "text",
        number = 0xFF6700, -- Color of the Text
        text = "(0.0.0)",
        position = {x = distancer.hud_x, y = distancer.hud_y+idx},
        direction = 1
    
    }) -- distancer.you:hud_add

end -- function add_hud_mapblock()

function distancer.add_hud_measure()
    
    local idx = .04
    distancer.hud_distance_label = distancer.you:hud_add(
    {
        name = "Mesure",    -- default ""
        hud_elem_type = "text",
        number = 0x00FF00, -- Color of the Text
        text = "Marker - Position - Distance",
        position = {x = distancer.hud_x, y = distancer.hud_y+idx},
        direction = 1
    
    }) -- distancer.you:hud_add

    idx = idx + .02
    distancer.hud_marker = distancer.you:hud_add(
    {
        name = "Marker_Value",    -- default ""
        hud_elem_type = "text",
        number = 0xFF6700, -- Color of the Text
        text = "(0.0.0)",
        position = {x = distancer.hud_x, y = distancer.hud_y+idx},
        direction = 1
    
    }) -- distancer.you:hud_add

    idx = idx + .02
    distancer.hud_position = distancer.you:hud_add(
    {
        name = "Position_Value",    -- default ""
        hud_elem_type = "text",
        number = 0xFFFF00, -- Color of the Text
        text = "(0.0.0)",
        position = {x = distancer.hud_x, y = distancer.hud_y+idx},
        direction = 1
    
    }) -- distancer.you:hud_add

    idx = idx + .02
    distancer.hud_distance = distancer.you:hud_add(
    {
        name = "Distance_Value",    -- default ""
        hud_elem_type = "text",
        number = 0xFFFFFF, -- Color of the Text
        text = "(0.0.0)",
        position = {x = distancer.hud_x, y = distancer.hud_y+idx},
        direction = 1
    
    }) -- distancer.you:hud_add
      
end -- distancer.add_hud_measure()

function distancer.remove_hud_mapblock()
    distancer.you:hud_remove(distancer.hud_mapblock_label)
    distancer.you:hud_remove(distancer.hud_mapblock)
    distancer.hud_mapblock_label = nil
    distancer.hud_mapblock = nil
    
end -- function distancer.remove_hud_mapblock

function distancer.remove_hud_measure()
    distancer.you:hud_remove(distancer.hud_distance_label)
    distancer.you:hud_remove(distancer.hud_marker)
    distancer.you:hud_remove(distancer.hud_position)
    distancer.you:hud_remove(distancer.hud_distance)
    distancer.hud_distance_label = nil
    distancer.hud_marker = nil
    distancer.hud_position = nil
    distancer.hud_distance = nil
    
end -- function distancer.remove_hud_measure

function distancer.check_hud_mapblock()
    local on = false
    
    if(distancer.hud_mapblock_label ~= nil and distancer.hud_mapblock ~= nil) then
            on = true
                                                       
    end -- if(distancer.hud_mapblock_label
    
    return on
    
end -- distancer.check_hud_mapblock

function distancer.check_hud_measure()
    local on = false
    
    if(distancer.hud_mapblock_label ~= nil and distancer.hud_mapblock ~= nil) then
            on = true
                                                       
    end -- if(distancer.hud_mapblock_label
    
    return on
    
end -- distancer.check_hud_mapblock

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
    
    distancer.print(distancer.green .. "Position of HUD changed to: ".. distancer.orange .. "X = " .. position.x .. " Y = " .. position.y .. distancer.green .. ".")
    
    if(mapblock) then
        distancer.add_hud_mapblock()
    end
    
    if(measure) then
        distancer.add_hud_measure()
    end
    
    return true
    
end -- function distancer.change_hud_position

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

function distancer.hud_speed(speed)
    if(speed >= 0 and speed ~= nil) then
        distancer.speed = speed
        distancer.update_hud()
        distancer.print(distancer.green .. "Distancer-HUD will now update all " .. distancer.orange .. distancer.speed .. distancer.green .. " seconds.\n")

    else
        distancer.speed = 0
        distancer.print(distancer.green .. "Distancer-HUD will now not updated.\n")

    end -- if(speed >= 0

end -- distancer.hud_speed(

--[[
   ****************************************************************
   *******        Main for Distancer                         ******
   ****************************************************************
--]]

-- Get yourself
distancer.you = minetest.localplayer               

--[[
minetest.register_globalstep(function(dtime) 
    distancer.update_hud()

end)  -- minetest.register_globalstep
]]--

minetest.after(distancer.speed, function()
    distancer.update_hud()
              
end) -- minetest.after(
               



--[[
   ****************************************************************
   *******        Registered Chatcommands                    ******
   ****************************************************************
--]]

minetest.register_chatcommand("distancer_who_is_online", {

    params = "<>",
    description = "Shows you all online Playernames.\nUsage:\n<> shows you all Playernames.\n",
    func = function()
    
        local online = minetest.get_player_names()
        if(online == nil) then 
                distancer.print(distancer.green .. "No Player is online?\n")
                return
                                        
        else
            table.sort(online)
    
        end -- if(online == nil
                                            
        distancer.print(distancer.green .. "Player now online:\n")
                                        
        for pl, name in pairs(online) do
            distancer.print(distancer.green .. pl .. ": " .. distancer.orange .. name .. "\n")
        
        end -- for
    end -- function
                                            
}) -- chatcommand who_is_online

minetest.register_chatcommand("distancer_show_mapblock",{

    params = "<>",
    description = "Shows the current Mapblock, where you are.",
    func = function()
                                              
        local pos_string = distancer.get_mapblock()
        if(pos_string ~= nil) then
            distancer.print(distancer.green .. "Current Mapblocknumber: (" .. distancer.orange .. pos_string .. distancer.green .. ")\n")
        
        else
            distancer.print(distancer.red .. "Couldn't calculate the Mapblocknr.")
                                               
        end -- if(pos_string ~= nil
                                               
                                               
    end -- function
                                              
}) -- chatcommand show_mapblock


minetest.register_chatcommand("distancer_hud_mapblock",{

    params = "on|off",
    description = "Turn's the HUD for the Mapblock on or off.",
    func = function(param)
                                                       
        local parameter = param:lower()
        if(parameter == "on") then
            if(not distancer.check_hud_mapblock()) then
                distancer.add_hud_mapblock()
                                                       
            else
                distancer.print(distancer.orange .. "HUD for Mapblock already on.")
                                                       
            end -- if(distancer.hud_mapblock_label
        
        elseif(parameter == "off") then
            if(distancer.check_hud_mapblock()) then
                distancer.remove_hud_mapblock()
            
            else
                distancer.print(distancer.orange .. "HUD for Mapblock isn't on.")
                                                       
            end -- if(distancer.hud_mapblock_label
        
        else
            distancer.print(distancer.red .. "Wrong or no Parameter for .distancer_hud_mapblock\n")
            distancer.print(distancer.orange .. "Usage: .distancer_hud_mapblock on|off")
                                                       
        end -- if(parameter ==
                                                       
    end -- function(param
                                                       
}) -- chatcommand distancer_hud_mapblock

minetest.register_chatcommand("distancer_hud_measure",{

    params = "on|off",
    description = "Turn's the HUD for the Distancemeasure on or off.",
    func = function(param)
                                                       
        local parameter = param:lower()
        if(parameter == "on") then
            if(not distancer.check_hud_measure()) then
                distancer.add_hud_measure()
                                                       
            else
                distancer.print(distancer.orange .. "HUD for Distancemeasure already on.")
                                                       
            end -- if(distancer.hud_mapblock_label
        
        elseif(parameter == "off") then
            if(distancer.check_hud_measure) then
                distancer.remove_hud_measure()
            
            else
                distancer.print(distancer.orange .. "HUD for Distancemeasure isn't on.")
                                                       
            end -- if(distancer.hud_mapblock_label
        
        else
            distancer.print(distancer.red .. "Wrong or no Parameter for .distancer_hud_measure\n")
            distancer.print(distancer.orange .. "Usage: .distancer_hud_measure on|off")
                                                       
        end -- if(parameter ==
                                                       
    end -- function(param
                                                       
}) -- chatcommand distancer_hud_mapblock

    
minetest.register_chatcommand("distancer_marker",{

    params = "<> | -s | -m | -p | -w X,Y,Z",
    description = "\n<> shows you the stored Marker.\n-s - Set's the Marker to your current Position.\n-m - Shows the Distance from your Marker.\n-p - Shows the Distance from your Marker as Vector\n-w X,Y,Z - Set's the Marker to X,Y,Z",
    func = function(param)
        
        local parameter = param:lower()
        local command = {}
        
        command = distancer.split(parameter)
        local current_position = distancer.you:get_pos()
        current_position = distancer.convert_position(current_position)
                                         
        -- No Node or Index given
        if(command[1] == nil or command[1] == "") then
            if(distancer.marker ~= nil) then
                                         
                distancer.print(distancer.green .. "Current Marker is @ " .. distancer.orange .. minetest.pos_to_string(distancer.marker))
                                         
            else
                distancer.print(distancer.green .. "Current Marker is " .. distancer.orange .. " not set.\n")
                                 
            end -- if(distancer.marker ~=
    
        elseif(command[1] == "-s") then
            distancer.marker = current_position
            distancer.print(distancer.green .. "Marker set to " .. distancer.orange .. minetest.pos_to_string(distancer.marker))
                                         
        elseif(command[1] == "-m") then
            if(distancer.marker ~= nil) then
                                         
                distancer.print(distancer.green .. "Current Marker is @ " .. distancer.yellow .. minetest.pos_to_string(distancer.marker))
                distancer.print(distancer.green .. "Your Position is @ " .. distancer.orange .. minetest.pos_to_string(current_position))
                                         
                local distance = math.floor(vector.distance(current_position, distancer.marker))
                                         
                distancer.print(distancer.green .. "You are " .. distancer.light_blue .. distance .. distancer.green .. " Nodes far away.")
                                         
            else
                                         
                distancer.print(distancer.green .. "Current Marker is " .. distancer.orange .. " not set " .. distancer.green .. " to calculate a Distance.\n")
                                         
            end -- if(distancer.marker ~= nil
        
        elseif(command[1] == "-w") then
            
            if(command[2] == nil or command[2] == "") then
                distancer.print(distancer.red .. "No Position to set Marker given.\n")
                                         
            else
                if(tonumber(command[2]) ~= nil and tonumber(command[3]) ~= nil and tonumber(command[4]) ~= nil) then
                    local new_marker = "(" .. tonumber(command[2]) .. "," .. tonumber(command[3]) .. "," .. tonumber(command[4]) .. ")"
                    distancer.print(distancer.green .. "Marker set to : " .. distancer.orange .. new_marker .. "\n")
                    distancer.marker = minetest.string_to_pos(new_marker)
                    distancer.marker = distancer.convert_position(distancer.marker)
                                         
                else
                    distancer.print(distancer.red .. "Wrong Position(format) given.\n")
                                                                                       
                end -- if(command[3] .. command[4]
                                                                                       
            end -- if(command[2] ~= nil
                                         
        elseif(command[1] == "-p") then                                         
            
            if(distancer.marker ~= nil) then
                    local distance = distancer.calc_distance_pos(distancer.marker, current_position)
                    distancer.print(distancer.green .. "Current Marker is @ " .. distancer.yellow .. minetest.pos_to_string(distancer.marker))
                    distancer.print(distancer.green .. "Your Position is @ " .. distancer.orange .. minetest.pos_to_string(current_position))
                    distancer.print(distancer.green .. "The Distance between them is: " .. distancer.white .. minetest.pos_to_string(distance))
                    distancer.print(distancer.green .. "You have to go " .. distancer.light_blue .. distance.x .. distancer.green .. " Steps at X-Axis.")
                    distancer.print(distancer.green .. "You have to go " .. distancer.light_blue .. distance.y .. distancer.green .. " Steps at Y-Axis.")
                    distancer.print(distancer.green .. "You have to go " .. distancer.light_blue .. distance.z .. distancer.green .. " Steps at Z-Axis.")
            else
                distancer.print(distancer.red .. "No Marker set.\n")
                                                                                       
            end -- if(distancer.marker ~= nil
                                         
        end -- if(command[1] ==
                                        
    end -- function
                                              
}) -- chatcommand show_mapblock

minetest.register_chatcommand("distancer_change_hud",{

    params = "<> | -r | -w .X,.Y",
    description = "\n<> shows you the current Position.\n-r - Resets the Position to default.\n-w 0.X,0.Y - Changes the Position in Percentage of the HUD",
    func = function(param)
        
        local parameter = param:lower()
        local command = {}
        
        command = distancer.split(parameter)
                                                              
        if(command[1] == nil or command[1] == "") then
            distancer.get_hud_position()
        
        elseif(command[1] == "-r") then         -- Reset the Position
            distancer.hud_reset()

        elseif(command[1] == "-w") then         -- Changes the Position
            local position = {}
            local x, y
            x = tonumber(command[2]) or 0
            y = tonumber(command[3]) or 0
            position.x = x
            position.y = y
            if(not distancer.change_hud_position(position)) then
                    distancer.print(distancer.red .. "Wrong Positiondata given.\n" .. distancer.orange .. "X = " .. position.x .. "\n" .. distancer.orange .. "Y = " .. position.y .. "\n")
                                                     
            end
        
        else -- Unknown Command given
            distancer.print(distancer.red .. "Unknown Command for .distancer_change_hud given.\n" .. distancer.orange .. "Usage: .distancer_change_hud <> | -r | -w .X,.Y\n")
                                                     
        end -- if(command[1] ==
                                                              
    end -- function
                                                              
}) -- chatcommand distancer_change_hud

minetest.register_chatcommand("distancer_hud_speed",{
    param = "<> | -s Seconds",
    description = "\n<> shows you the current Updatespeed in Seconds of the HUD.\n-s Seconds set's the new Value in Seconds. 0 turns the HUD off.",
    func = function(param)
        local parameter = param:lower()
        local command = {}
                                                    
        command = distancer.split(parameter)
                                                    
        if(command[1] == nil or command[1] == "") then
            if(distancer.speed > 0) then
                distancer.print(distancer.green .. "The HUD of Distancer will update every " .. distancer.orange .. distancer.speed .. distancer.green .. " Seconds.\n")
                                                    
            else
                distancer.print(distancer.green .. "The HUD of Distancer is off.\n")
                                                    
            end -- if(distancer.speed
        else
            local newspeed = tonumber(command[1]) or 0
            distancer.hud_speed(newspeed)
                                                    
        end -- if(command[1] ==
                                                    
    end -- function
                                                    
}) -- chatcommand distancer_hud_speed

minetest.register_chatcommand("distancer_version",{
    
    params = "<>",
    description = "Shows the current Revision of ".. distancer.modname .. ".",
    func = function ()
        
        distancer.print(distancer.green .. "Client-Side-Mod: " .. distancer.modname .. distancer.orange .. " v " .. distancer.version .. "." .. distancer.revision .. "\n")
        
    end -- function

}) -- chatcommand distancer_version
        
       
   
                                                    
