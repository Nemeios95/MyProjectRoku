sub init()
    m.app = App()
    m.rowlist = m.top.findNode("rowlist")
    m.label = m.top.findNode("label")
    m.posterBackG = m.top.findNode("posterBackG")

    m.rowlist.update(m.app.gridFields)
    m.label.update(m.app.labelFields)
    m.rowlist.observeField("rowItemFocused", "onRowItemFocused")
    m.rowlist.observeField("rowItemFocused", "onRowItemSelected")

    m.httpTask = createObject("roSGNode", "httpTask")
    m.httpTask.term = "Animate"
    m.httpTask.observeField("response", "onHttpResponse")
    m.httpTask.control = "run"

    m.keyboard = m.top.findNode("keyboard")
    m.keyboard.observeField("text", "onKeyboardTextChanged")
    m.keyboard.textEditBox.observeField("cursorPosition", "onCursorPositionChanged")
    m.top.observefield("focusedChild", "onFocusChanged")
end sub

sub onHttpResponse(event as object)
    response = event.getData()

    m.rowlist.content = response.content
    m.rowlist.setFocus(true)

    m.httpTask.control = "stop"
    m.httpTask.unobserveField("response")
    m.httpTask = invalid
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    handled = false
    if press = true then
        if key = "right" and m.keyboard.hasFocus() then
            m.rowlist.setFocus(true)
            handled = true
            stop
        else if key = "left" and m.rowlist.hasFocus() then
            m.keyboard.setFocus(true)
            'stop
            handled = true
        else if key = "OK" then
            print "OK"
            stop
            onItemSelected()
            handled = true
        end if
        return handled
    end if
end function

sub onKeyboardTextChanged(event as dynamic)
    print "tecla"
    term = event.getData()
    if term <> "" and term.len() > 1
        m.httpTask = createObject("roSGNode", "httpTask")
        m.httpTask.observeField("response", "onHttpResponse")
        m.httpTask.term = term
        m.httpTask.control = "run"
    end if
end sub

sub onRowItemFocused(event as object)
    rowItemIndex = event.getData()

    content = m.rowlist.content
    rowContent = content.getChild(rowItemIndex[0])
    itemContent = rowContent.getChild(rowItemIndex[1])

    m.label.text = itemContent.title
    print m.label.text
end sub

'sub onRowItemSelected(event as object)
sub onRowItemSelected()
    print "ok"
    if m.label.text = "The Animated Passion"
        m.top.event = {
            type: "VIDEO_PLAYER"
            data: {}
        }
    end if
end sub

sub onItemSelected()


end sub

