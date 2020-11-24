distancer.register_help({
                            Name = "change_safe_dead",
                            Usage = ".dis change_safe_dead <> | on | off",
                            Description = "Turns the safe_dead-mode on or off or show's the status of safe_dead-mode.",
                            Parameter = "<> | on | off" .. distancer.green .. "." ..
                                        "\n" .. distancer.orange .. "<> - " ..
                                        distancer.green .. "shows the current state of the safe_dead-mode." ..
                                        "\n" .. distancer.orange .. "on" ..
                                        distancer.green.. " - Turn's the safe_dead_mode on." ..
                                        "\n" .. distancer.orange .. "off" ..
                                        distancer.green .. " - Turn's the safe_dead_mode off."
                        }
                       )


distancer.commands["change_safe_dead"] = function(parameter)
    if(parameter[2] == nil) then
        if(distancer.safe_dead_state) then
            distancer.print(distancer.green .. "The safe_dead_status of the Distancer is on.")

        else
            distancer.print(distancer.orange .. "The safe_dead_status of the Distancer is off.")

        end -- if(distancer.safe_dead_state

    elseif(parameter[2] == "on") then
        if(distancer.safe_dead_state) then
            distancer.print(distancer.green .. "The safe_dead_status is already on.")

        else
            distancer.safe_dead_state = true
            distancer.print(distancer.green .. "Turning the safe_dead_status om.")

        end -- if(distancer.safe_dead_state

    elseif(parameter[2] == "off") then
        if(distancer.safe_dead_state) then
            distancer.print(distancer.orange .. "Turning the safe_dead_status off.")
            distancer.safe_dead_state = false

        else
            distancer.print(distancer.orange .. "The safe_dead_status is already off.")

        end -- if(distancer.safe_dead_state
    else
        distancer.print(distancer.orange .. "change_safe_dead: unknown Parameter " ..
                        distancer.red .. parameter[2] .. distancer.orange .. ".")

    end -- if(parameter ==

end -- distancer.change_safe_dead()
