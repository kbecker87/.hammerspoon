local fnutils = require "hs.fnutils"
local layouts = {}

layouts['Vertikal'] = function(windows)
  local winCount = #windows

  if winCount == 1 then
    return layouts['fullscreen'](windows)
  end

  for index, win in pairs(windows) do
    local frame = win:screen():frame()

    if index == 1 then
      frame.w = frame.w / 2
    else
      frame.x = frame.x + frame.w / 2
      frame.w = frame.w / 2
      frame.h = frame.h / (winCount - 1)
      frame.y = frame.y + frame.h * (index - 2)
    end

    win:setFrame(frame)
  end
end

layouts['Horizontal'] = function(windows)
  local winCount = #windows

  if winCount == 1 then
    return layouts['fullscreen'](windows)
  end

  for index, win in pairs(windows) do
    local frame = win:screen():frame()

    if index == 1 then
      frame.h = frame.h / 2
    else
      frame.y = frame.y + frame.h / 2
      frame.h = frame.h / 2
      frame.w = frame.w / (winCount - 1)
      frame.x = frame.x + frame.w * (index - 2)
    end

    win:setFrame(frame)
  end
end

layouts['Spalten'] = function(windows)
  local winCount = #windows

  if winCount == 1 then
    return layouts['fullscreen'](windows)
  end

  for index, win in pairs(windows) do
    local frame = win:screen():frame()

    frame.w = frame.w / winCount
    frame.x = frame.x + (index - 1) * frame.w
    frame.y = 0

    win:setFrame(frame)
  end
end

layouts['Zeilen'] = function(windows)
  local winCount = #windows

  if winCount == 1 then
    return layouts['fullscreen'](windows)
  end

  for index, win in pairs(windows) do
    local frame = win:screen():frame()

    frame.h = frame.h / winCount
    frame.y = frame.y + (index - 1) * frame.h
    frame.x = 0

    win:setFrame(frame)
  end
end

layouts['gp-horizontal'] = function(windows)
  local winCount = #windows

  if winCount == 1 then
    return layouts['fullscreen'](windows)
  end

  local width 
  local height
  local x = 0
  local y = 0

  for index, win in pairs(windows) do
    local frame = win:screen():frame()
  
    if index == 1 then
      height = frame.h / 2
      width  = frame.w 
    elseif index % 2 == 0 then
      if index ~= winCount then
        width = width / 2
      end
      y = y + height
    else 
      if index ~= winCount then
        height = height / 2
      end
      x = x + width
    end
  
    frame.x = frame.x + x
    frame.y = frame.y + y
    frame.w = width
    frame.h = height

    win:setFrame(frame)
  end
end

return layouts