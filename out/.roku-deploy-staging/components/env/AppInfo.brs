function getAppInfo()
    if m.appInfo = invalid
        m.appInfo = CreateObject("roAppInfo")
    end if

    return m.appInfo
end function

function getImageBaseUrl(imageType as String) as String
    if (imageType = "poster")
        return getAppInfo().GetValue("image_base_url") + "/w342"
    else if (imageType = "backdrop")
        return getAppInfo().GetValue("image_base_url") + "/w1280"
    else
        return getAppInfo().GetValue("image_base_url") + "/w500"
    end if

end function
