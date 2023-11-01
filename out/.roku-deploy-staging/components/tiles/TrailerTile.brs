function init() as void
    m.thumbnail = m.top.findNode("thumbnail")
end function

function itemContentChanged() as void
    itemData = m.top.itemContent
    m.thumbnail.uri = "pkg:/images/thumb.png"
end function