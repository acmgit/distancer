local distancer = {}

distancer.version = 1
distancer.revision = 0
distancer.modname = "Distancer"

distancer.you = nil -- Player
distancer.waypoint = nil

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
        
    end -- if(distancer.waypoint ~= nil
    
    return nil
end -- function convert_position
--[[
   ****************************************************************
   *******        Main for Prospector                        ******
   ****************************************************************
--]]

-- Get yourself
minetest.register_on_connect(function()
    distancer.you = minetest.localplayer               
end)


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
    
        end
                                            
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
        
        local mypos = distancer.you:get_pos()
        local x = math.floor(mypos.x+0.5)
        local y = math.floor(mypos.y+0.5)
        local z = math.floor(mypos.z+0.5)
    
        local pos_string = math.floor(x / 16) .. "." .. math.floor(y / 16) .. "." .. math.floor(z / 16)
        
        distancer.print(distancer.green .. "Current Mapblocknumber: (" .. distancer.orange .. pos_string .. distancer.green .. ")\n")
    end -- function
                                              
}) -- chatcommand show_mapblock

minetest.register_chatcommand("waypoint",{

    params = "<> | -s | -m | -p | -w X,Y,Z",
    description = "\n<> shows you the stored Waypoint.\n-s - Set's the Waypoint to your current Position.\n-m - Shows the Distance from your Waypoint.\n-p - Shows the Distance from your Waypoint as Vector\n-w X,Y,Z - Set's the Waypoint to X,Y,Z",
    func = function(param)
        
        local parameter = param:lower()
        local command = {}
        
        command = distancer.split(parameter)
        local current_position = distancer.you:get_pos()
        current_position = distancer.convert_position(current_position)
                                         
        -- No Node or Index given
        if(command[1] == nil or command[1] == "") then
            if(distancer.waypoint ~= nil) then
                                         
                distancer.print(distancer.green .. "Current Waypoint is @ " .. distancer.orange .. minetest.pos_to_string(distancer.waypoint))
                                         
            else
                distancer.print(distancer.green .. "Current Waypoint is " .. distancer.orange .. " not set.\n")
                                 
            end -- if(distancer.waypoint ~=
    
        elseif(command[1] == "-s") then
            distancer.waypoint = current_position
            distancer.print(distancer.green .. "Waypoint set to " .. distancer.orange .. minetest.pos_to_string(distancer.waypoint))
                                         
        elseif(command[1] == "-m") then
            if(distancer.waypoint ~= nil) then
                                         
                distancer.print(distancer.green .. "Current Waypoint is @ " .. distancer.yellow .. minetest.pos_to_string(distancer.waypoint))
                distancer.print(distancer.green .. "Your Position is @ " .. distancer.orange .. minetest.pos_to_string(current_position))
                                         
                local distance = math.floor(vector.distance(current_position, distancer.waypoint))
                                         
                distancer.print(distancer.green .. "You are " .. distancer.light_blue .. distance .. distancer.green .. " Nodes far away.")
                                         
            else
                                         
                distancer.print(distancer.green .. "Current Waypoint is " .. distancer.orange .. " not set " .. distancer.green .. " to calculate a Distance.\n")
                                         
            end -- if(distancer.waypoint ~= nil
        
        elseif(command[1] == "-w") then
            
            if(command[2] == nil or command[2] == "") then
                distancer.print(distancer.red .. "No Position to set Waypoint given.\n")
                                         
            else
                if(tonumber(command[2]) ~= nil and tonumber(command[3]) ~= nil and tonumber(command[4]) ~= nil) then
                    local new_waypoint = "(" .. tonumber(command[2]) .. "," .. tonumber(command[3]) .. "," .. tonumber(command[4]) .. ")"
                    distancer.print(distancer.green .. "Waypoint set to : " .. distancer.orange .. new_waypoint .. "\n")
                    distancer.waypoint = minetest.string_to_pos(new_waypoint)
                    distancer.waypoint = distancer.convert_position(distancer.waypoint)
                                         
                else
                    distancer.print(distancer.red .. "Wrong Position(format) given.\n")
                                                                                       
                end -- if(command[3] .. command[4]
                                                                                       
            end -- if(command[2] ~= nil
                                         
        elseif(command[1] == "-p") then                                         
            
            if(distancer.waypoint ~= nil) then
                    local distance = distancer.calc_distance_pos(distancer.waypoint, current_position)
                    distancer.print(distancer.green .. "Current Waypoint is @ " .. distancer.yellow .. minetest.pos_to_string(distancer.waypoint))
                    distancer.print(distancer.green .. "Your Position is @ " .. distancer.orange .. minetest.pos_to_string(current_position))
                    distancer.print(distancer.green .. "The Distance between them is: " .. distancer.white .. minetest.pos_to_string(distance))
                    distancer.print(distancer.green .. "You have to go " .. distancer.light_blue .. distance.x .. distancer.green .. " Steps at X-Axis.")
                    distancer.print(distancer.green .. "You have to go " .. distancer.light_blue .. distance.y .. distancer.green .. " Steps at Y-Axis.")
                    distancer.print(distancer.green .. "You have to go " .. distancer.light_blue .. distance.z .. distancer.green .. " Steps at Z-Axis.")
            else
                distancer.print(distancer.red .. "No Waypoint set.\n")
                                                                                       
            end -- if(distancer.waypoint ~= nil
                                         
        end -- if(command[1] ==
                                        
    end -- function
                                              
}) -- chatcommand show_mapblock

minetest.register_chatcommand("distancer_version",{
    
    params = "<>",
    description = "Shows the current Revision of ".. distancer.modname .. ".",
    func = function ()
        
        distancer.print(distancer.green .. "Client-Side-Mod: " .. distancer.modname .. distancer.orange .. "v " .. distancer.version .. "." .. distancer.revision .. "\n")
        
    end -- function

}) -- chatcommand distancer_version
        
       
   
                                                    
