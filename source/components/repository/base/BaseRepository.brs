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
        

        m.uriMap = {
            "nowPlaying": baseUrl + "/"+ apiVersion +"/movie/now_playing?api_key=" + getApiKey()
            "popular": baseUrl + "/"+ apiVersion +"/movie/popular?api_key=" + getApiKey()
            "topRated": baseUrl + "/"+ apiVersion +"/movie/top_rated?api_key=" + getApiKey()
            "upcoming": baseUrl + "/"+ apiVersion +"/movie/upcoming?api_key=" + getApiKey()
            "movieDetails": baseUrl + "/"+ apiVersion +"/movie/{{movieid}}?api_key=" + getApiKey()
            "movieTrailers": baseUrl + "/"+ apiVersion +"/movie/{{movieid}}/videos?api_key=" + getApiKey()
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
