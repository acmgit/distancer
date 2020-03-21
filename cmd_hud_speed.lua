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
