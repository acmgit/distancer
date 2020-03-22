distancer.register_help({
                            Name = "help",
                            Usage = ".dis help <> | <command>",
                            Description = "Helpsystem for the Distancer.",
                            Parameter = "<> | <command>" .. distancer.green .. "." ..
                                        "\n" .. distancer.orange .. "<>" .. distancer.green.. " - Shows you the entire help for distancer." ..
                                        "\n" .. distancer.orange .. "<command>" .. distancer.green .. " - Shows you the help for the distancer-command."
                        }
                       )

distancer["help"] = function(parameter)
    if(parameter[2] == "" or parameter[2] == nil) then
        distancer.print(distancer.green .. "Commands for the Distancer " .. distancer.orange .. distancer.version .. "." .. distancer.revision .. distancer.green .. ".")
        for _,value in pairs(distancer.helpsystem) do
            distancer.print(distancer.yellow .. "---------------")
            distancer.print(distancer.green .. "Name: " .. distancer.orange .. value.Name)
            distancer.print(distancer.green .. "Description: " .. distancer.yellow .. value.Description) 
            distancer.print(distancer.green .. "Usage: " .. distancer.orange .. value.Usage)
            distancer.print(distancer.green .. "Parameter: " .. distancer.orange .. value.Parameter)
        end -- for _,value
        distancer.print(distancer.yellow .. "---------------")
        
    else
        if(distancer.helpsystem[parameter[2]] ~= nil) then
            distancer.print(distancer.green .. "Name: " .. distancer.orange .. distancer.helpsystem[parameter[2]].Name)
            distancer.print(distancer.green .. "Description: " .. distancer.yellow .. distancer.helpsystem[parameter[2]].Description)
            distancer.print(distancer.green .. "Usage: " .. distancer.orange .. distancer.helpsystem[parameter[2]].Usage)
            distancer.print(distancer.green .. "Parameter: " .. distancer.orange .. distancer.helpsystem[parameter[2]].Parameter)
                         
        else
            distancer.print(distancer.red .. "No entry in help for command <" .. distancer.orange .. parameter[2] .. distancer.red .. "> found.")
            
        end -- if(distancer.help[parameter[2
        
    end -- if(parameter[2]
                         
end -- function help
    

--[[
    distancer.print(distancer.green .. "Distancer V " .. distancer.orange .. distancer.version .. "." ..
                    distancer.revision .. distancer.green .. ".")

    distancer.print(distancer.green .. "\n*** General Commands: ***")
    distancer.print(distancer.green .. ".dis who = " .. distancer.orange .. "Shows you all online Playernames.")
    distancer.print(distancer.green .. ".dis show_mapblock = " ..
                    distancer.orange .. "Shows the current Mapblock, where you are.")
    distancer.print(distancer.green .. ".dis change_safe_dead = " ..
                    distancer.orange .. "Turns the safe_dead on or off or show's the status of safe_dead.")
    distancer.print(distancer.green .. "   Parameter: " ..
                    distancer.yellow .. "<> | on | off")
    distancer.print(distancer.green .. ".dis restore_marker " ..
                    distancer.orange .. "Try to restore the old Postion before dead on the Marker.")

    distancer.print(distancer.green .. "\n*** Marker Commands: ***")
    distancer.print(distancer.green .. ".dis mark = " .. distancer.orange .. "Commands for the marker.")
    distancer.print(distancer.green .. "   Parameter: " .. distancer.yellow .. "<> | -s | -m | -p | -w X,Y,Z")
    distancer.print(distancer.orange .. "   <> - " .. distancer.yellow .. "shows you the stored Marker.")
    distancer.print(distancer.orange .. "   -s - " ..
                    distancer.yellow .. "Set's the Marker to your current Position.")
    distancer.print(distancer.orange .. "   -m - " .. distancer.yellow .. "Shows the Distance from your Marker.")
    distancer.print(distancer.orange .. "   -p - " ..
                    distancer.yellow .. "Shows the Distance from your Marker as Vector.")
    distancer.print(distancer.orange .. "   -w - " .. distancer.yellow .. "X,Y,Z - Set's the Marker to X,Y,Z")

    distancer.print(distancer.green .. "\n*** Hud Commands: ***")
    distancer.print(distancer.green .. ".dis hud = " .. distancer.orange .. "Turn's all Distancer-HUD's on or off.")
    distancer.print(distancer.green .. "   Parameter: " .. distancer.yellow .. "on | off")
    distancer.print(distancer.green .. ".dis hud_mapblock = " ..
                    distancer.orange .. "Turn's the HUD for the Mapblock on or off.")
    distancer.print(distancer.green .. "   Parameter: " .. distancer.yellow .. "on | off")
    distancer.print(distancer.green .. ".dis hud_measure = " ..
                    distancer.orange .. "Turn's the HUD for Measuring on or off.")
    distancer.print(distancer.green .. "   Parameter: " .. distancer.yellow .. "on | off")
    distancer.print(distancer.green .. ".dis hud_waypoint = " ..
                    distancer.orange .. "Turn's the HUD for the Waypoint on or off.")
    distancer.print(distancer.green .. "   Parameter: " .. distancer.yellow .. "on | off | -c [colorname]")
    distancer.print(distancer.green .. ".dis hud_set = " ..
                    distancer.orange .. "Sets or shows the Position of the Huds.")
    distancer.print(distancer.green .. "   Parameter: " .. distancer.yellow .. "<> | -r | -w .X,.Y")
    distancer.print(distancer.orange .. "   <> - " .. distancer.yellow .. "shows you the current Position.")
    distancer.print(distancer.orange .. "   -r - " .. distancer.yellow .. "Resets the Position to default.")
    distancer.print(distancer.orange .. "   -w 0.X,0.Y - " ..
                    distancer.yellow .. "Changes the Position in Percentage of the HUD")
    distancer.print(distancer.green .. ".dis hud_speed = " ..
                    distancer.orange .. "Changes or sets the speed of update of the HUD.")
    distancer.print(distancer.green .. "   Parameter: " .. distancer.yellow .. "<> | -s Seconds")
    distancer.print(distancer.orange .. "   <> - " ..
                    distancer.yellow .. "shows you the current Updatespeed in Seconds of the HUD.")
    distancer.print(distancer.orange .. "   -s - " ..
                    distancer.yellow .. "Seconds set's the new Value in Seconds. 0 turns the HUD off.")

end
]]--
