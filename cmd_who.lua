distancer["who"] = function()
    local online = minetest.get_player_names()
    if(online == nil) then
        distancer.print(distancer.green .. "No Player is online?\n")
        return

    else
        table.sort(online)

    end -- if(online == nil

    distancer.print(distancer.green .. "Player now online:\n")

    for pl, name in pairs(online) do
        distancer.print(distancer.green .. pl .. ": " .. distancer.orange .. name .. "\n")

    end -- for

end -- distancer["who"
