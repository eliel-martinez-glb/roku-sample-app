sub showHomeScreen()
    m.homeScreen = CreateObject("roSGNode", "HomeScreen")
    m.homeScreen.ObserveField("rowItemSelected", "onHomeScreenItemSelected")
    showScreen(m.homeScreen) ' show HomeScreen
end sub

sub onHomeScreenItemSelected(event as Object)
    sender = event.GetRoSGNode()
    m.selectedIndex = sender.rowItemSelected
    featuredRowList = sender.FindNode("featuredRowList")
    rowContent = featuredRowList.content.GetChild(m.selectedIndex[0]).getChild(m.selectedIndex[1])
    showDetailsScreen(rowContent, m.selectedIndex)
end sub