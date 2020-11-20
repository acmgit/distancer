distancer.register_help({
                            Name = "hud_waypoint",
                            Usage = ".dis hud_waypoint on | off",
                            Description = "Turn's the HUD for the waypoint on or off.",
                            Parameter = "on | off" .. distancer.green .. "." ..
                                        "\n" .. distancer.orange .. "on" .. distancer.green.. " - Turn's the HUD on." ..
                                        "\n" .. distancer.orange .. "off" .. distancer.green .. " - Turn's the HUD off."
                        }
                       )

distancer["hud_waypoint"] = function(parameter)
    if(parameter[2] == "on") then
        if(not distancer.check_hud_waypoint()) then
            if(distancer.marker == nil) then
                distancer.marker = {x = 0, y = 0, z = 0}

            end -- if(distancer.marker == nil

            distancer.add_hud_waypoint()
            distancer.print(distancer.green .. "Distancer: Hud for the Waypoint on.")

        else
            distancer.print(distancer.orange .. "HUD for Waypoint already on.")

        end -- if(distancer.check_hud_waypoint

    elseif(parameter[2] == "off") then
        if(distancer.check_hud_waypoint()) then
            distancer.remove_hud_waypoint()
            distancer.print(distancer.green .. "Distancer: Hud for the Waypoint off.")

        else
            distancer.print(distancer.orange .. "HUD for Waypiont isn't on.")

        end -- if(distancer.check_hud_waypoint

    elseif(parameter[2] == "-c") then
            if(parameter[3] ~= nil and distancer.hud_color[parameter[3]] ~= nil) then -- Color is valid
                distancer.hud_waypoint_color = distancer.hud_color[parameter[3]]
                distancer.refresh_hud_waypoint()
                distancer.print(distancer.green .. "Color for Waypoint set to " ..
                distancer.orange .. parameter[3] .. distancer.green .. ".\n")

            else
                distancer.print(distancer.green .. "Waypoint Colors are:\n")
                for key,value in pairs(distancer.hud_color) do
                    distancer.print(distancer.yellow .. key .. distancer.green .. " = " ..
                    distancer.orange .. string.format("0x%06X",value) .. "\n")

                end -- for(key, value

            end -- if(distancer.hud_color[command[2]] ~= nil

    else
        distancer.print(distancer.red .. "Wrong or no Parameter for .dis hud_waypoint.\n")
        distancer.print(distancer.orange .. "Usage: .dis hud_waypoint on|off|-c [colorname]")

    end -- if(command ==

end -- distancer.set_hud_waypoint(
