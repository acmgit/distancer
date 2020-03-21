distancer["hud_set"] = function(parameter)
    if(parameter[2] == nil or parameter[2] == "") then
        distancer.get_hud_position()

    elseif(parameter[2] == "-r") then         -- Reset the Position
        distancer.hud_reset()

    elseif(parameter[2] == "-w") then         -- Changes the Position
        local position = {}
        local x, y
        x = tonumber(parameter[3]) or 0
        y = tonumber(parameter[4]) or 0
        position.x = x
        position.y = y
        if(not distancer.change_hud_position(position)) then
            distancer.print(distancer.red .. "Wrong Positiondata given.\n" ..
            distancer.orange .. "X = " .. position.x .. "\n" .. distancer.orange .. "Y = " .. position.y .. "\n")

        end -- if(not distancher.change_hud_position

    else -- Unknown Command given
        distancer.print(distancer.red .. "Unknown Command for .dis hud_set given.\n" ..
        distancer.orange .. "Usage: .dis hud_set <> | -r | -w .X,.Y\n")

    end -- if(command[1] ==

end -- distancer.dhud_set
