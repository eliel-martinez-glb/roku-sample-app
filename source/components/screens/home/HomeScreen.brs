sub init()
    m.theme = Theme().getCurrent()
    applyTheme()

    m.featuredRowList = m.top.FindNode("featuredRowList")
    m.repository = createObject("roSGNode", "ContentRepository")
    fetchHomeContent()
    m.featuredRowList.ObserveField("rowItemFocused", "onRowItemFocused")
    m.top.ObserveField("visible", "onVisibleChange")
end sub

sub onVisibleChange() ' invoked when GridScreen change visibility
    if m.top.visible = true
        m.featuredRowList.SetFocus(true) ' set focus to rowList if GridScreen visible
    end if
end sub

function onRowItemFocused() as void
    focusedItem = m.featuredRowList.rowItemFocused
    if focusedItem <> invalid 
        row = focusedItem[0]
        col = focusedItem[1]
        rowItem = m.featuredRowList.content.getChild(row)
        videoContent = rowItem.getChild(col)
        m.selectedContentTitle.text = videoContent.title
        m.selectedContentDescription.text = videoContent.description
        m.currentItemImage.uri = getImageBaseUrl("backdrop") + videoContent.backdrop
    end if
end function

sub applyTheme()
    m.selectedContentTitle = m.top.FindNode("selectedContentTitle")
    m.selectedContentTitle.color = Theme().getCurrent().colors.mainText
    m.selectedContentDescription = m.top.FindNode("selectedContentDescription")
    m.selectedContentDescription.color = Theme().getCurrent().colors.mainText
    m.currentItemImage = m.top.FindNode("currentItemImage")
end sub

sub fetchHomeContent()
    m.data = CreateObject("roSGNode", "ContentNode")
    
    httpResponse = createObject("roSGNode", "HttpResponseNode")
    httpResponse.observeField("response", "onFetchNowLoaded")

    reqArgs = {
        "httpResponse": httpResponse
    }

    m.repository.callFunc("fetchNowPlaying", reqArgs)
end sub

sub onFetchNowLoaded(event as Object)
    response = event.getData()
    
    row = m.data.CreateChild("ContentNode")
    row.title = "Now Playing"
    for each contentItem in response.data.contentRow
        item = row.CreateChild("ContentItemData")
        item.id = contentItem.id
        item.title         = contentItem.title
        item.description   = contentItem.description
        item.poster        = contentItem.poster
        item.backdrop  = contentItem.backdrop
    end for
    
    fetchUpcomingContent()
end sub

sub fetchUpcomingContent()
    httpResponse = createObject("roSGNode", "HttpResponseNode")
    httpResponse.observeField("response", "onFetchUpcomingLoaded")

    reqArgs = {
        "httpResponse": httpResponse
    }

    m.repository.callFunc("fetchUpcoming", reqArgs)
end sub

sub onFetchUpcomingLoaded(event as Object)
    response = event.getData()
    
    row = m.data.CreateChild("ContentNode")
    row.title = "Upcoming"
    for each contentItem in response.data.contentRow
        item = row.CreateChild("ContentItemData")
        item.id = contentItem.id
        item.title         = contentItem.title
        item.description   = contentItem.description
        item.poster        = contentItem.poster
        item.backdrop  = contentItem.backdrop
    end for
    
    setUpContent()
end sub

sub setUpContent()
    m.featuredRowList.content = m.data
    m.featuredRowList.SetFocus(true)
end sub
