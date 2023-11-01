function parseData(data)
    if type(data) = "roArray"
        m.top.addFields({data: data})
    else
        m.top.addFields(data)
    end if
end function
