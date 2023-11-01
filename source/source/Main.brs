sub Main()
    ' Create a screen for the main content
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)

    ' Create the main scene for the Home Screen
    mainScene = screen.CreateScene("MainScene")
    screen.show()

    ' Initialize the side menu
    ' sideMenuScene = CreateObject("roSGNode", "SideMenu")
    ' sideMenu = sideMenuScene.findNode("sideMenuRowList")
    ' sideMenu.observeField("itemSelected", "onMenuItemSelected")
    ' sideMenu.content = [
    '     {title: "Home", sceneName: "HomeScreen"},
    '     {title: "Movies", sceneName: "MoviesScreen"},
    '     {title: "Series", sceneName: "SeriesScreen"}
    ' ]
    ' sideMenuScene.transition = "slide"
    ' screen.append(sideMenuScene)

    ' Event loop for navigation
    while true
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed()
                exit while
            end if
        end if
    end while
end sub

sub onMenuItemSelected()
    selectedMenuItem = m.top.findNode("sideMenuRowList").getFocusedChild()
    if selectedMenuItem <> invalid
        ' Get the scene name from the selected menu item
        sceneName = selectedMenuItem.sceneName

        ' Create and show the selected scene
        if sceneName <> invalid
            scene = CreateObject("roSGScreen")
            port = CreateObject("roMessagePort")
            scene.setMessagePort(port)
            selectedScene = CreateObject("roSGNode", sceneName)
            scene.show()
            scene.append(selectedScene)
        end if
    end if
end sub
