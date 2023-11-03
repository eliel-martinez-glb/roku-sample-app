sub init()
    m.top.id = "HttpClient"
    m.httpTask = createObject("roSGNode", "HttpTask")
    m.httpTask.control = "RUN"
    generateApiPaths()
end sub

function enqueueCall(request as object)
    m.httpTask.request = request
end function

function HttpEncode(str as string) as string
    return str.Escape()
end function

function translateUri(uri as String, args as object) as string
    url = m.uriMap[uri]
    if (args <> invalid)
        for each key in args
            print "key" + key
            url = url.replace("{{" + key + "}}", args[key])
        end for
    end if


    return url
end function

sub generateApiPaths()
    if m.uriMap = invalid
        baseUrl = getAppBaseUrl()
        apiVersion = getApiVersion()
        apiKey = getApiKey()
        youtubeBaseUrl = getYoutubeBaseUrl()
        youtubeApiKey = getYoutubeApiKey()
        

        m.uriMap = {
            "nowPlaying": baseUrl + "/"+ apiVersion +"/movie/now_playing?api_key=" + apiKey
            "popular": baseUrl + "/"+ apiVersion +"/movie/popular?api_key=" + apiKey
            "topRated": baseUrl + "/"+ apiVersion +"/movie/top_rated?api_key=" + apiKey
            "upcoming": baseUrl + "/"+ apiVersion +"/movie/upcoming?api_key=" + apiKey
            "movieDetails": baseUrl + "/"+ apiVersion +"/movie/{{movieid}}?api_key=" + apiKey
            "movieTrailers": baseUrl + "/"+ apiVersion +"/movie/{{movieid}}/videos?api_key=" + apiKey
            "trailerInfo": youtubeBaseUrl +"/videos?part=snippet&id={{trailers}}&key=" + youtubeApiKey
        }

    end if
end sub

function getAppBaseUrl() as String
    env = getAppInfo().GetValue("api_env")

    if env = "prod"
        return getAppInfo().GetValue("prod_base_url")
    else
        return getAppInfo().GetValue("qa_base_url")
    end if
end function

function getApiVersion() as String
    return getAppInfo().GetValue("api_version")
end function

function getApiKey() as String
    return getAppInfo().GetValue("apikey")
end function

function getYoutubeApiKey() as String
    return getAppInfo().GetValue("youtube_api_key")
end function

function getYoutubeBaseUrl() as String
    return getAppInfo().GetValue("youtube_api_base_url")
end function
