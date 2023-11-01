sub init()
    m.top.id = "MovieModel"
end sub

function parseData(data)
    
        array= {
            id: data.id
            title: data.original_title
            description: data.overview
            poster: data.poster_path
            backdrop: data.backdrop_path
        }

    m.top.movie = array

end function