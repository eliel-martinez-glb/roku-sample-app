sub init()
    m.top.id = "ContentModel"
end sub

function parseData(data)
    contentRow = []
    for each node in data.results

        array               = {}
        array.id            = node.id
        array.title         = node.original_title
        array.description   = node.overview
        array.poster        = node.poster_path
        array.backdrop      = node.backdrop_path

        contentRow.push(array)
    end for

    m.top.contentRow = contentRow

end function