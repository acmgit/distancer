distancer.register_help({
                            Name = "restore_marker",
                            Usage = ".dis restore_marker",
                            Description = "Try to restore the old Postion before dead on the Marker.",
                            Parameter = ""
                        }
                       )

distancer["restore_marker"] = function()
    if(distancer.old_marker ~= nil) then
        distancer.marker = distancer.old_marker
        distancer.print(distancer.green .. "Old Markerposition restored.")
        distancer.old_marker = nil

    else
        distancer.print(distancer.red .. "No old Markerposition to restore found.")

    end -- if(distancer.old_marker

end -- distancer.restore_marker(
