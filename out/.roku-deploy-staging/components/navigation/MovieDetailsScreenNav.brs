sub showDetailsScreen(content as Object, selectedItem as Object)
    m.selectedItem = selectedItem
    detailsScreen = CreateObject("roSGNode", "MovieDetailsScreen")
    detailsScreen.movieId = content.id
    ' detailsScreen.jumpToItem = m.selectedItem[1]
    detailsScreen.ObserveField("visible", "onDetailsScreenVisibilityChanged")
    showScreen(detailsScreen)
end sub

sub onDetailsScreenVisibilityChanged(event as Object) 
    visible = event.GetData()
    detailsScreen = event.GetRoSGNode()
    if visible = false
        m.homeScreen.jumpToRowItem = [m.selectedItem[0], m.selectedItem[1]]
    end if
end sub
