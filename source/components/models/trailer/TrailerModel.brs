sub init()
    m.top.id = "TrailerModel"
end sub

function parseData(data)
    trailers = []
    for each trailer in data.items
        array = {}
        array.id = trailer.id
        if trailer.snippet.thumbnails.standard <> invalid
            array.thumbnail = trailer.snippet.thumbnails.standard.url
        else
            array.thumbnail = trailer.snippet.thumbnails.default.url
        end if
        trailers.push(array)
    end for

    m.top.trailers = trailers

end function