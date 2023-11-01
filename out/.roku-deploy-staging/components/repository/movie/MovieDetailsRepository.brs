function fetchMovieDetails(reqArgs as Object)
    args = {
        movieid: reqArgs.movieId
    }
    print args
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