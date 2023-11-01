function Theme() as object
  return {
    getCurrent: function()
      return BaseTheme()
    end function
  }
end function

function BaseTheme() as object
  this = {
    colors: {
      mainText: "0xfafafa"
      descriptionText: "0xC6CBD4"
      channelName: "0x9ea3ad"
      mainBackground: "0x28334a"
    }
    getRegularFont: function(size as integer) as object
      calloutFont = CreateObject("roSGNode", "Font")
      calloutFont.uri = "pkg:/fonts/TT Norms Regular.otf"
      calloutFont.size = size
      return calloutFont
    end function

    getRegularItalicedFont: function(size as integer) as object
      calloutFont = CreateObject("roSGNode", "Font")
      calloutFont.uri = "pkg:/fonts/TTNorms-Italic.otf"
      calloutFont.size = size
      return calloutFont
    end function

    getMediumFont: function(size as integer) as object
      calloutFont = CreateObject("roSGNode", "Font")
      calloutFont.uri = "pkg:/fonts/TT Norms Medium.otf"
      calloutFont.size = size
      return calloutFont
    end function

    getBoldFont: function(size as integer) as object
      calloutFont = CreateObject("roSGNode", "Font")
      calloutFont.uri = "pkg:/fonts/TT Norms Bold.otf"
      calloutFont.size = size
      return calloutFont
    end function
  }
  
  return this
end function
