distancer.register_help({
                            Name = "hud_speed",
                            Usage = ".dis hud_speed <> | -s Seconds",
                            Description = "Changes or sets the speed of update for the HUD.",
                            Parameter = "<> | -s Seconds" .. distancer.green .. "." ..
                                        "\n" .. distancer.orange .. "<> - " ..
                                        distancer.green .. "shows you the current Updatespeed in Seconds of the HUD." ..
                                        "\n" .. distancer.orange .. "-s Seconds - " ..
                                        distancer.green .. "Seconds set's the new Value in Seconds. 0 freeze the HUD."
                        }
                       )

distancer["hud_speed"] = function(parameter)
        if(parameter[2] == nil or parameter[2] == "") then
            if(distancer.speed > 0) then
                distancer.print(distancer.green .. "The HUD of Distancer will update every " ..
                distancer.orange .. distancer.speed .. distancer.green .. " Seconds.\n")

            else
                distancer.print(distancer.green .. "The HUD of Distancer is off.\n")

            end -- if(distancer.speed
        else
            local newspeed = tonumber(parameter[3]) or 0
            distancer.hud_set_speed(newspeed)

        end -- if(command[1] ==

end -- distancer.dhug_speed
