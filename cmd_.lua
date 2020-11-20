distancer.register_help({
                            Name = "mymodule",
                            Usage = ".dis mymodule",
                            Description = "Enter the description of you module.",
                            Parameter = "Has your command Parameter?"
                        }
                       )

distancer["mymodule"] = function()

-- Here you can write your own code

end -- distancer["who"
