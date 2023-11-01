sub init()
    m.theme = Theme().getCurrent()
    applyTheme()

    ' m.featuredRowList = m.top.FindNode("featuredRowList")
    m.repository = createObject("roSGNode", "MovieDetailsRepository")
    ' fetchMovieDetails()
    ' m.featuredRowList.ObserveField("rowItemFocused", "onRowItemFocused")
end sub

sub onMovieIdChanged()
    fetchMovieDetails()
end sub


' function onRowItemFocused() as void
'     focusedItem = m.featuredRowList.rowItemFocused
'     if focusedItem <> invalid 
'         row = focusedItem[0]
'         col = focusedItem[1]
'         rowItem = m.featuredRowList.content.getChild(row)
'         videoContent = rowItem.getChild(col)
'         m.selectedContentTitle.text = videoContent.title
'         m.selectedContentDescription.text = videoContent.description
'         m.currentItemImage.uri = getImageBaseUrl("backdrop") + videoContent.backdrop
'     end if
' end function

sub applyTheme()
    m.selectedContentTitle = m.top.FindNode("selectedContentTitle")
    m.selectedContentTitle.color = Theme().getCurrent().colors.mainText
    m.selectedContentDescription = m.top.FindNode("selectedContentDescription")
    m.selectedContentDescription.color = Theme().getCurrent().colors.mainText
    m.currentItemImage = m.top.FindNode("currentItemImage")
end sub

sub fetchMovieDetails()
    m.data = CreateObject("roSGNode", "ContentNode")
    
    httpResponse = createObject("roSGNode", "HttpResponseNode")
    httpResponse.observeField("response", "onFetchMovieDetailsLoaded")

    reqArgs = {
        "httpResponse": httpResponse
        "movieId": m.top.movieId
    }

    m.repository.callFunc("fetchMovieDetails", reqArgs)
end sub

sub onFetchMovieDetailsLoaded(event as Object)
    response = event.getData()
    
    print response.data.movie
    movie = response.data.movie
    m.selectedContentTitle.text = movie.title
    m.selectedContentDescription.text = movie.description
    m.currentItemImage.uri = getImageBaseUrl("backdrop") + movie.backdrop
end sub

' sub fetchUpcomingContent()
'     httpResponse = createObject("roSGNode", "HttpResponseNode")
'     httpResponse.observeField("response", "onFetchUpcomingLoaded")

'     reqArgs = {
'         "httpResponse": httpResponse
'     }

'     m.repository.callFunc("fetchUpcoming", reqArgs)
' end sub

' sub onFetchUpcomingLoaded(event as Object)
'     response = event.getData()
    
'     row = m.data.CreateChild("ContentNode")
'     row.title = "Upcoming"
'     for each contentItem in response.data.contentRow
'         item = row.CreateChild("ContentItemData")
'         item.id = contentItem.id
'         item.title         = contentItem.title
'         item.description   = contentItem.description
'         item.poster        = contentItem.poster
'         item.backdrop  = contentItem.backdrop
'     end for
    
'     setUpContent()
' end sub

' sub setUpContent()
'     m.featuredRowList.content = m.data
'     m.featuredRowList.SetFocus(true)
' end sub
