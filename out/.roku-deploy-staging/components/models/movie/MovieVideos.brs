sub init()
    m.top.id = "MovieVideos"
end sub

function parseData(data)
    videos = []
    for each node in data.results

        array               = {}
        array.id            = node.id
        array.name         = node.name
        array.key   = node.key
        array.site        = node.site

        videos.push(array)
    end for

    m.top.videos = videos

end function