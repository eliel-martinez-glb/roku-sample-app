function init() as void
    m.thumbnail = m.top.findNode("thumbnail")
end function

function itemContentChanged() as void
    itemData = m.top.itemContent
    m.thumbnail.uri = itemData.thumb
end function