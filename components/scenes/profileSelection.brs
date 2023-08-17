sub init()
    m.jsonParser = createObject("roSGNode", "JsonParser")
    m.jsonParser.functionName = "getJsonFile"
    m.jsonParser.observeField("content", "setContent")
    m.jsonParser.jsonFilePath = "pkg:/source/json/profiles.json"
    m.jsonParser.control = "run"

    m.profiles = m.top.findNode("profiles")
    'm.profiles.observeField("labelText", "onProfileSelected")
    'm.profiles.setFocus(true)
    m.router = Router()
    m.router.initialize(m.scenes)

    m.layoutGroup = m.top.findNode("layoutGroup")
    m.top.observeField("focusedChild", "onFocusChanged")
end sub

sub setContent(event as object)
    content = event.getData()
    for i = 0 to content.count() - 1
        profileItem = content[i]
        profile = createObject("roSGNode", "customItem")
        profile.id = profileItem.id
        profile.labelText = profileItem.name
        m.strname = profile.labelText
        print type(m.strname)
        'print tostr(m.strname)
        profile.posterUri = profileItem.imagePath
        m.profiles.appendChild(profile)
    end for

    m.top.index = 0
    m.top.maxIndex = m.profiles.getChildCount() - 1
    m.layoutGroup.translation = calculateTranslation(m.layoutGroup)
end sub

sub onFocusChanged()
    'profilename = onProfileSelected(m.strname)
    'print "señuelo" + profilename
    if m.top.isInFocusChain() and m.lastFocused <> invalid then
        m.profiles.getChild(m.top.index).setFocus(true)

    end if
    
end sub

sub onIndexChange(event as object)
    index = event.getData()
    m.profiles.getChild(index).setFocus(true)

end sub

sub routingEventCallback(evt as object)
    event = evt.getData()
        m.router.navigateToScene("rowList", event.data, false)

end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    print "Tecla", key
    if press
        if key = "right"
            if m.top.index < m.top.maxIndex
                m.top.index++
                print "index++ ", m.top.index
            end if
            handled = true
        else if key = "left"
            if m.top.index > 0
                m.top.index--
                print "index-- ", m.top.index
            end if
            handled = true
        else if key = "OK" then
            onProfileSelected()
            handled = true
            end if
    end if
    return handled
end function

sub onProfileSelected()

    m.top.event = {
        type: "HOME_SCENE"
        data: {}
    }
    'm.router.navigateToScene("homeScene", {}, false)
end sub