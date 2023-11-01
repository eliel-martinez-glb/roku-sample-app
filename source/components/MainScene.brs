sub init()
    m.top.setFocus(true)

    ' Set the initial visible screen (HomeScreen or MovieDetailsScreen)
    m.top.findNode("homeScreen").visible = true
    m.top.findNode("movieDetailsScreen").visible = false
end sub


