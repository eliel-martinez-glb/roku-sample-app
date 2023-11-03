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
        item.name = video.name
        item.key = video.key
        item.site = video.site
    end for
    
    ' m.trailersRowList.content = m.videos
    ' m.trailersRowList.SetFocus(true)
    fetchTrailerInfo()
end sub

sub fetchTrailerInfo()
    container = m.videos.getChild(0)
    m.trailers = container.getChildren(container.getChildCount(), 0)
    trailerIds = []
    for each trailer in m.trailers
        trailerIds.push(trailer.key)
    end for

    httpResponse = createObject("roSGNode", "HttpResponseNode")
    httpResponse.observeField("response", "onFetchTrailerInfoLoaded")

    reqArgs = {
        "httpResponse": httpResponse
        "trailers": trailerIds.join("%2C")
    }

    m.repository.callFunc("fetchTrailerInfo", reqArgs)
end sub

sub onFetchTrailerInfoLoaded(event as Object)
    response = event.getData()

    m.thumbs = CreateObject("roSGNode", "ContentNode")
    row = m.thumbs.CreateChild("ContentNode")
    row.title = "Trailers"
    for each thumb in response.data.trailers
        item = row.CreateChild("ThumbItemData")
        item.id = thumb.id
        item.thumb = thumb.thumbnail
        item.streamUrl = "https://media-results.s3.amazonaws.com/short_3_10sec.m3u8"
    end for
    
    print m.thumbs
    m.trailersRowList.content = m.thumbs
    m.trailersRowList.SetFocus(true)
end sub
