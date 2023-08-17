sub init()
    m.posterBackG = m.top.findNode("posterBackG")
    m.scenes = m.top.findNode("scenes")
    m.topRef = m.top
    m.router = Router()
    m.router.initialize(m.scenes)

    m.layoutGroup = m.top.findNode("layoutGroup")
    m.signInButton = m.top.findNode("signInButton")
    m.signInButton.observeField("pressed", "onButtonPressed")
    m.signInButton.setFocus(true)

    m.signUpButton = m.top.findNode("signUpButton")
    m.signUPButton.observeField("pressed", "onButtonPressed")

    m.layoutGroup.translation = calculateTranslation(m.layoutGroup)

    m.top.observeField("focusedChild", "onFocusChanged")

end sub

sub onFocusChanged()
    if m.top.hasFocus()
        m.signInButton.setFocus(true)
    end if
end sub

sub onButtonPressed()
    if m.signInButton.hasFocus()
        m.router.navigateToScene("LoginScene", {}, false)
    else
        ' TODO: Add Sihn Up Scene
    end if
end sub

sub routingEventCallback(evt as object)
    event = evt.getData()
    if event.type = "SIGN_IN" then
        m.router.navigateToScene("ProfileSelection", event.data, false)
    else if event.type = "HOME_SCENE" then
        m.router.navigateToScene("homeScene", event.data, false)
    else if event.type = "VIDEO_PLAYER" then
        m.router.navigateToScene("videoPlayer", event.data, false)
    end if
end sub

function onKeyEvent(key as string, press as boolean) as Boolean
    handled = false
    if press
        if key = "back" then
            m.router.navigateToPreviousScene()
            handled = true
        else if key = "up"
            if m.signUpButton.hasFocus() then m.signInButton.setFocus(true)
        else if key = "down"
            if m.signInButton.hasFocus() then m.signUpButton.setFocus(true)
        end if
    end if
    return handled
end function
