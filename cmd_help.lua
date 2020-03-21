distancer["help"] = function()
    distancer.print(distancer.green .. "Distancer V " .. distancer.orange .. distancer.version .. "." ..
                    distancer.revision .. distancer.green .. ".")

    distancer.print(distancer.green .. "\n*** General Commands: ***")
    distancer.print(distancer.green .. ".dis who = " .. distancer.orange .. "Shows you all online Playernames.")
    distancer.print(distancer.green .. ".dis show_mapblock = " ..
                    distancer.orange .. "Shows the current Mapblock, where you are.")
    distancer.print(distancer.green .. ".dis change_safe_dead = " ..
                    distancer.orange .. "Turns the safe_dead on or off or show's the status of safe_dead. ")
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
