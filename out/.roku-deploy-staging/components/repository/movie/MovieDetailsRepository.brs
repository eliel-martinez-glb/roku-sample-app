function fetchMovieDetails(reqArgs as Object)
    args = {
        movieid: reqArgs.movieId
    }
    url = translateUri("movieDetails", args)

    headers = {
        "Content-Type" : "application/json"
    }

    request = {
        method: "GET",
        url: url,
        headers: headers,
        httpResponse: reqArgs.httpResponse,
        modelType: "MovieModel"
    }

    enqueueCall(request)

end function

function fetchMovieTrailers(reqArgs as Object)
    args = {
        movieid: reqArgs.movieId
    }
    url = translateUri("movieTrailers", args)

    headers = {
        "Content-Type" : "application/json"
    }

    request = {
        method: "GET",
        url: url,
        headers: headers,
        httpResponse: reqArgs.httpResponse,
        modelType: "MovieVideos"
    }

    enqueueCall(request)

end function

function fetchTrailerInfo(reqArgs as Object)
    args = {
        trailers: reqArgs.trailers
    }
    print args
    url = translateUri("trailerInfo", args)

    headers = {
        "Content-Type" : "application/json"
    }

    request = {
        method: "GET",
        url: url,
        headers: headers,
        httpResponse: reqArgs.httpResponse,
        modelType: "TrailerModel"
    }

    enqueueCall(request)

end function