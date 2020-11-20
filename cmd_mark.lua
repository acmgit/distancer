local pos_to_string = minetest.pos_to_string
local string_to_pos = minetest.string_to_pos


distancer.register_help({
                            Name = "mark",
                            Usage = ".dis mark <> | -s | -m | -p | -w X,Y,Z",
                            Description = "Commands for the marker.",
                            Parameter = "<> | -s | -m | -p | -w X,Y,Z" .. distancer.green .. "." ..
                                        "\n" .. distancer.orange .. "<> - " ..
                                        distancer.green .. "shows you the stored Marker." ..
                                        "\n" .. distancer.orange .. "-s - " ..
                                        distancer.green .. "Set's the Marker to your current Position." ..
                                        "\n" .. distancer.orange .. "-m - " ..
                                        distancer.green .. "Shows the Distance to your Marker." ..
                                        "\n" .. distancer.orange .. "-p - " ..
                                        distancer.green .. "Shows the Distance to your Marker as Vector." ..
                                        "\n" .. distancer.orange .. "-w X,Y,Z - " ..
                                        distancer.green .. "X,Y,Z - Set's the Marker to X,Y,Z."
                        }
                       )

distancer["mark"] = function(parameter)
        --local command = distancer.split(parameter)
        local current_position = minetest.localplayer:get_pos()

        current_position = distancer.convert_position(current_position)

        -- No Node or Index given
        if(parameter[2] == nil or parameter[2] == "") then
            if(distancer.marker ~= nil) then

                distancer.print(distancer.green .. "Current Marker is @ " ..
                distancer.orange .. pos_to_string(distancer.marker))

            else
                distancer.print(distancer.green .. "Current Marker is " .. distancer.orange .. " not set.\n")

            end -- if(distancer.marker ~=

        elseif(parameter[2] == "-s") then
            distancer.marker = current_position
            distancer.hud_waypoint_name = pos_to_string(distancer.marker)
            distancer.print(distancer.green .. "Marker set to " .. distancer.orange .. pos_to_string(distancer.marker))
            distancer.refresh_hud_waypoint()

        elseif(parameter[2] == "-m") then
            if(distancer.marker ~= nil) then

                distancer.print(distancer.green .. "Current Marker is @ " ..
                distancer.yellow .. pos_to_string(distancer.marker))
                distancer.print(distancer.green .. "Your Position is @ " ..
                distancer.orange .. pos_to_string(current_position))

                local distance = math.floor(vector.distance(current_position, distancer.marker))

                distancer.print(distancer.green .. "You are " .. distancer.light_blue .. distance ..
                distancer.green .. " Nodes far away.")

            else

                distancer.print(distancer.green .. "Current Marker is " .. distancer.orange .. " not set " ..
                distancer.green .. " to calculate a Distance.\n")

            end -- if(distancer.marker ~= nil

        elseif(parameter[2] == "-w") then

            if(parameter[3] == nil or parameter[3] == "") then
                distancer.print(distancer.red .. "No Position to set Marker given.\n")

            else
                if(tonumber(parameter[3]) ~= nil and tonumber(parameter[4]) ~= nil and
                   tonumber(parameter[5]) ~= nil) then
                    local new_marker = "(" .. tonumber(parameter[3]) .. "," ..
                    tonumber(parameter[4]) .. "," .. tonumber(parameter[5]) .. ")"
                    distancer.print(distancer.green .. "Marker set to : " .. distancer.orange .. new_marker .. "\n")
                    distancer.marker = string_to_pos(new_marker)
                    distancer.marker = distancer.convert_position(distancer.marker)
                    distancer.hud_waypoint_name = pos_to_string(distancer.marker)
                    distancer.refresh_hud_waypoint()

                else
                    distancer.print(distancer.red .. "Wrong Position(format) given.\n")

                end -- if(parameter[4] .. parameter[5]

            end -- if(parameter[3] ~= nil

        elseif(parameter[2] == "-p") then

            if(distancer.marker ~= nil) then
                    local distance = distancer.calc_distance_pos(distancer.marker, current_position)
                    distancer.print(distancer.green .. "Current Marker is @ " ..
                    distancer.yellow .. pos_to_string(distancer.marker))
                    distancer.print(distancer.green .. "Your Position is @ " ..
                    distancer.orange .. pos_to_string(current_position))
                    distancer.print(distancer.green .. "The Distance between them is: " ..
                    distancer.white .. pos_to_string(distance))
                    distancer.print(distancer.green .. "You have to go " ..
                    distancer.light_blue .. distance.x .. distancer.green .. " Steps at X-Axis.")
                    distancer.print(distancer.green .. "You have to go " ..
                    distancer.light_blue .. distance.y .. distancer.green .. " Steps at Y-Axis.")
                    distancer.print(distancer.green .. "You have to go " ..
                    distancer.light_blue .. distance.z .. distancer.green .. " Steps at Z-Axis.")
            else
                distancer.print(distancer.red .. "No Marker set.\n")

            end -- if(distancer.marker ~= nil

        end -- if(parameter[2] ==

end -- distancer["mark"(
