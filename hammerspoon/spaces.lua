local function moveWindow(eventName, params)
  print("Running " .. eventName)
  local targetSpace = params["space"]
  print("targetSpace: " .. targetSpace)
  local names = assert(hs.spaces.missionControlSpaceNames())
  print(names)

  local ok, err
  for _, screen in ipairs(names) do
    for spaceId, name in pairs(screen) do
      print("screen: " .. screen .. ", spaceId: " .. spaceId .. "name: " .. name)
      local num = string.gsub(name, "Desktop (%d+)", "%1")
      if targetSpace == num then
        ok, err = hs.spaces.moveWindowToSpace(hs.window.focusedWindow(), spaceId)
        break
      end
    end
    if ok or err then
      break
    end
  end

  if not ok then
    if err then
      error(err)
    else
      error("Error: Could not find Dekstop ", targetSpace)
    end
  end
end

hs.urlevent.bind("mvwindow", moveWindow)
-- hammerspoon://mvwindow?space=4
