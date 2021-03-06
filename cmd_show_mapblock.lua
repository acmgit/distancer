distancer.register_help({
                            Name = "show_mapblock",
                            Usage = ".dis show_mapblock",
                            Description = "Shows the current Mapblock, where you are.",
                            Parameter = ""
                        }
                       )

distancer.commands["show_mapblock"] = function()
    local pos_string = distancer.get_mapblock()
    if(pos_string ~= nil) then
        distancer.print(distancer.green .. "Current Mapblocknumber: (" .. distancer.orange .. pos_string ..
        distancer.green .. ")\n")

    else
        distancer.print(distancer.red .. "Couldn't calculate the Mapblocknr.")

    end -- if(pos_string ~= nil

end -- distancer["show_mapblock"](
