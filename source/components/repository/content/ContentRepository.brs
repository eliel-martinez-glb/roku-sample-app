function fetchNowPlaying(reqArgs as Object)
    url = translateUri("nowPlaying", invalid)

    headers = {
        "Content-Type" : "application/json"
    }

    request = {
        method: "GET",
        url: url,
        headers: headers,
        httpResponse: reqArgs.httpResponse,
        modelType: "ContentModel"
    }

    enqueueCall(request)

end function

function fetchUpcoming(reqArgs as Object)
    url = translateUri("upcoming", invalid)

    headers = {
        "Content-Type" : "application/json"
    }

    request = {
        method: "GET",
        url: url,
        headers: headers,
        httpResponse: reqArgs.httpResponse,
        modelType: "ContentModel"
    }

    enqueueCall(request)

end function