sub init()
    m.top.opacity = 0.5
    m.profBackground = m.top.findNode("profileBackground")
    m.top.observeFieldScoped("focusedChild","onFocusChange")
end sub

sub onFocusChange(event as object)
    print "customItem: ", event.getNode(), m.top.hasFocus()
    if m.top.hasFocus()
        m.top.opacity = 1.0
        m.profBackground.opacity = "1.0"
    else
        m.top.opacity = 0.5
        m.profBackground.opacity = "0.5"
    end if
end sub
