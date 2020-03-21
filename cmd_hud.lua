distancer["hud"] = function(parameter)

    if(parameter[2] == "" or parameter[2] == nil) then
        distancer.print(distancer.red .. "Wrong or no Parameter for .dis hud\n")
        distancer.print(distancer.orange .. "Usage: .dis hud on|off")

    else
        print("Hud Parameter: " .. parameter[2])
        
        if(distancer["hud_mapblock"]) then
            distancer["hud_mapblock"]({"hud_mapblock", parameter[2]})
            
        end
        
        if(distancer["hud_measure"]) then
            distancer["hud_measure"]({"hud_measure", parameter[2]})
            
        end
        
        if(distancer["hud_waypoint"]) then
            distancer["hud_waypoint"]({"hud_waypoint", parameter[2]})
            
        end
        
    end

end -- distancer.set_hud
