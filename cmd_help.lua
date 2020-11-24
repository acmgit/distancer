distancer.register_help({
                            Name = "help",
                            Usage = ".dis help <> | <command>",
                            Description = "Helpsystem for the Distancer.",
                            Parameter = "<> | <command>" .. distancer.green .. "." ..
                                        "\n" .. distancer.orange .. "<>" ..
                                        distancer.green.. " - Shows you the entire help for distancer." ..
                                        "\n" .. distancer.orange .. "<command>" ..
                                        distancer.green .. " - Shows you the help for the distancer-command."
                        }
                       )

distancer.commands["help"] = function(parameter)
    if(parameter[2] == "" or parameter[2] == nil) then
        distancer.print(distancer.green .. "Commands for the Distancer " .. distancer.orange ..
                        distancer.version .. "." .. distancer.revision .. distancer.green .. ".")
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
            distancer.print(distancer.green .. "Name: " .. distancer.orange ..
                            distancer.helpsystem[parameter[2]].Name)
            distancer.print(distancer.green .. "Description: " .. distancer.yellow ..
                            distancer.helpsystem[parameter[2]].Description)
            distancer.print(distancer.green .. "Usage: " .. distancer.orange ..
                            distancer.helpsystem[parameter[2]].Usage)
            distancer.print(distancer.green .. "Parameter: " .. distancer.orange ..
                            distancer.helpsystem[parameter[2]].Parameter)

        else
            distancer.print(distancer.red .. "No entry in help for command <" ..
                            distancer.orange .. parameter[2] .. distancer.red .. "> found.")

        end -- if(distancer.help[parameter[2

    end -- if(parameter[2]

end -- function help
