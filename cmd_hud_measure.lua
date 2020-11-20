distancer.register_help({
                            Name = "hud_measure",
                            Usage = ".dis hud_measure on | off",
                            Description = "Turn's the HUD for the measure on or off.",
                            Parameter = "on | off" .. distancer.green .. "." ..
                                        "\n" .. distancer.orange .. "on" .. distancer.green.. " - Turn's the HUD on." ..
                                        "\n" .. distancer.orange .. "off" .. distancer.green .. " - Turn's the HUD off."
                        }
                       )

distancer["hud_measure"] = function(parameter)
    if(parameter[2] == "on") then
        if(not distancer.check_hud_measure()) then
            distancer.add_hud_measure()
            distancer.print(distancer.green .. "Distancer: Hud for Measure on.")

        else
            distancer.print(distancer.orange .. "HUD for Measure already on.")

        end -- if(distancer.hud_measure

    elseif(parameter[2] == "off") then
        if(distancer.check_hud_measure()) then
            distancer.remove_hud_measure()
            distancer.print(distancer.green .. "Distancer: Hud for Measure off.")

        else
            distancer.print(distancer.orange .. "HUD for Measure isn't on.")

        end -- if(distancer.hud_mapblock_label

    else
        distancer.print(distancer.red .. "Wrong or no Parameter for .dis hud_measure\n")
        distancer.print(distancer.orange .. "Usage: .dis hud_measure on|off")

    end -- if(parameter ==

end -- distancer.set_hud_measure(
