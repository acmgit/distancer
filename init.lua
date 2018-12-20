local distancer = {}

distancer.version = 2
distancer.revision = 0
distancer.modname = "Distancer"

distancer.you = nil -- Player
distancer.marker = nil

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

-- Hud of the Distancer
distancer.hud_x = 0.9
distancer.hud_y = 0.5
distancer.hud_mapblock = nil
distancer.hud_marker = nil
distancer.hud_position = nil

--[[
   ****************************************************************
   *******        Functions for Prospector                   ******
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
        for word in string.gmatch(parameter, "[%w%-%:]+") do
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
    
end

function distancer.update_hud()
    if(distancer.hud_mapblock ~= nil) then
        distancer.you:hud_change(distancer.hud_mapblock, "text", distancer.get_mapblock())
        
    end -- if(distancer.hud_mapblock ~= nil
        
end -- distancer.update_hud

--[[
   ****************************************************************
   *******        Main for Prospector                        ******
   ****************************************************************
--]]

-- Get yourself
distancer.you = minetest.localplayer               

-- Add the HUD
local idx = 0
distancer.you:hud_add(
{
    name = "Mapblock",    -- default ""
    hud_elem_type = "text",
    number = 0x00FF00, -- Color of the Text
    text = "Current Mapblock",
    position = {x = distancer.hud_x, y = distancer.hud_y+idx},
    direction = 1
 
}) -- distancer.you:hud_add

idx = idx + .02
distancer.hud_mapblock = distancer.you:hud_add(
{
    name = "MB Value",    -- default ""
    hud_elem_type = "text",
    number = 0xFF6700, -- Color of the Text
    text = "(0.0.0)",
    position = {x = distancer.hud_x, y = distancer.hud_y+idx},
    direction = 1
    
}) -- distancer.you:hud_add

minetest.register_globalstep(function(dtime) 
    distancer.update_hud()
                            
end)

--[[                      
    text = "Current Mapblock",
    number = 0xFF6700,
    text = distancer.orange .. distancer.get_mapblock(),    -- default ""
    direction = 1
--    size = { x=100, y=100 },  -- default {x=0, y=0}
    --  ^ Size of element in pixels
]]--
                      
--[[
   ****************************************************************
   *******        Registered Chatcommands                    ******
   ****************************************************************
--]]

minetest.register_chatcommand("who_is_online", {

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
                                            
}) -- chatcommand searc

minetest.register_chatcommand("show_mapblock",{

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

minetest.register_chatcommand("marker",{

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

minetest.register_chatcommand("distancer_version",{
    
    params = "<>",
    description = "Shows the current Revision of ".. distancer.modname .. ".",
    func = function ()
        
        distancer.print(distancer.green .. "Client-Side-Mod: " .. distancer.modname .. distancer.orange .. " v " .. distancer.version .. "." .. distancer.revision .. "\n")
        
    end -- function

}) -- chatcommand distancer_version
        
       
   
                                                    
