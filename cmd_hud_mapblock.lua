distancer.register_help({
                            Name = "hud_mapblock",
                            Usage = ".dis hud_mapblock on | off",
                            Description = "Turn's the HUD for the mapblock on or off.",
                            Parameter = "on | off" .. distancer.green .. "." ..
                                        "\n" .. distancer.orange .. "on" .. distancer.green.. " - Turn's the HUD on." ..
                                        "\n" .. distancer.orange .. "off" .. distancer.green .. " - Turn's the HUD off."
                        }
                       )

distancer.commands["hud_mapblock"] = function(parameter)
    if(parameter[2] == "on") then
        if(not distancer.check_hud_mapblock()) then
            distancer.add_hud_mapblock()
            distancer.print(distancer.green .. "Distancer: Hud for Mapblock on.")

        else
            distancer.print(distancer.orange .. "HUD for Mapblock already on.")

        end -- if(distancer.hud_mapblock_label

    elseif(parameter[2] == "off") then
        if(distancer.check_hud_mapblock()) then
            distancer.remove_hud_mapblock()
            distancer.print(distancer.green .. "Distancer: Hud for Mapblock off.")

        else
            distancer.print(distancer.orange .. "HUD for Mapblock isn't on.")

        end -- if(distancer.hud_mapblock_label

    else
        distancer.print(distancer.red .. "Wrong or no Parameter for .dis hud_mapblock\n")
        distancer.print(distancer.orange .. "Usage: .dis hud_mapblock on|off")


    end -- if(parameter ==

end -- distancer.set_hud_mapblock(
