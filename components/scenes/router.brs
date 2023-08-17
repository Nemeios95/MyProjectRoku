function Router() as Object
    r = {
        top: m.topRef,
        history: [],
        initialize: _initialize,
        navigateToPreviousScene: _navigateToPreviousScene,
        navigateToScene: _navigateToScene,
        scenes: [],
    }
    return r
end function

function _initialize(scenes)
    m.scenes = scenes
end function

function _navigateToScene(name, data = {}, removeCurrentScene = false)
    print "-- _navigateToScene: " + name + " --"
    scene = createObject("roSGNode", name)
    scene.initData = data
    scene.observeField("event", "onSceneEvent")
    if m.history.count() > 0 and removeCurrentScene = true then
        print "-- remove scene --"
        if removeCurrentScene = true then
            removeScene(m.history.pop())
        else
            removeScene(m.history.peek())
        end if
    else if m.history.count() > 0 then
        currentScene = m.history.peek()
        currentScene.focused = false
        currentScene.visible = false
        currentScene.unobserveField("event")
    end if
    m.history.push(scene)
    m.scenes.appendChild(scene)
    scene.setFocus(true)
    return scene
end function

sub _navigateToPreviousScene()
    if m.history.count() > 0 then
        currentScene = m.history.pop()
        currentScene.visible = false
        currentScene.unobserveField("event")
        removeScene(currentScene)
        if (m.history.count() > 0)
            previousScene = m.history.peek()
            previousScene.observeField("event", "onSceneEvent")
            previousScene.visible = true
            previousScene.setFocus(true)
        else
            m.top.setFocus(true)
        end if
    end if
end sub

sub removeScene(scene)
    scene.unobserveField("event")
    m.scenes.removeChild(scene)
end sub

sub onSceneEvent(e)
    event = e.getData()
    m.top.routerCallback = event
end sub