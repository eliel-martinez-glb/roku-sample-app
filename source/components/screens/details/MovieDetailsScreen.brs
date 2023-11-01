sub init()
    m.theme = Theme().getCurrent()
    applyTheme()

    m.repository = createObject("roSGNode", "MovieDetailsRepository")
    m.trailersRowList = m.top.FindNode("trailersRowList")
end sub

sub onMovieIdChanged()
    fetchMovieDetails()
end sub


sub applyTheme()
    m.selectedContentTitle = m.top.FindNode("selectedContentTitle")
    m.selectedContentTitle.color = Theme().getCurrent().colors.mainText
    m.selectedContentDescription = m.top.FindNode("selectedContentDescription")
    m.selectedContentDescription.color = Theme().getCurrent().colors.mainText
    m.currentItemImage = m.top.FindNode("currentItemImage")
end sub

sub fetchMovieDetails()
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
    
    movie = response.data.movie
    m.selectedContentTitle.text = movie.title
    m.selectedContentDescription.text = movie.description
    m.currentItemImage.uri = getImageBaseUrl("backdrop") + movie.backdrop

    fetchMovieTrailers()
end sub


sub fetchMovieTrailers()
    httpResponse = createObject("roSGNode", "HttpResponseNode")
    httpResponse.observeField("response", "onFetchMovieTrailersLoaded")

    reqArgs = {
        "httpResponse": httpResponse
        "movieId": m.top.movieId
    }

    m.repository.callFunc("fetchMovieTrailers", reqArgs)
end sub

sub onFetchMovieTrailersLoaded(event as Object)
    response = event.getData()

    m.videos = CreateObject("roSGNode", "ContentNode")
    row = m.videos.CreateChild("ContentNode")
    row.title = "Trailers"
    for each video in response.data.videos
        item = row.CreateChild("TrailerItemData")
        item.id = video.id
        item.name         = video.name
        item.key   = video.key
        item.site        = video.site
    end for
    
    m.trailersRowList.content = m.videos
    m.trailersRowList.SetFocus(true)
end sub
