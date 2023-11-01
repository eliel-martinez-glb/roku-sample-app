function init()
    m.top.itemComponentName = "ContentTile"
    m.top.numRows = 2
    m.top.itemSize = [1230, 231]
    m.top.rowHeights = [231]
    m.top.rowItemSize = [ [154, 231] ]
    m.top.itemSpacing = [ 0, 80 ]
    m.top.rowItemSpacing = [ [20, 0] ]
    m.top.rowLabelOffset = [ [0, 30] ]
    m.top.rowFocusAnimationStyle = "floatingFocus"
    m.top.showRowLabel = [true, true]
    m.top.rowLabelColor="0xa0b033ff"
    m.top.visible = true
    m.top.SetFocus(true)
    ' m.top.ObserveField("rowItemFocused", "onRowItemFocused")
end function

