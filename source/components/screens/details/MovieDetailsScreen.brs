sub init()
    m.theme = Theme().getCurrent()
    applyTheme()

    m.repository = createObject("roSGNode", "MovieDetailsRepository")
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
    
    movie = response.data.movie
    m.selectedContentTitle.text = movie.title
    m.selectedContentDescription.text = movie.description
    m.currentItemImage.uri = getImageBaseUrl("backdrop") + movie.backdrop
end sub
