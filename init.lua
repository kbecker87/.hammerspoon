-----------------------------------------------
-- Hammerspoon Karl 9.9.16
-----------------------------------------------
hs.window.animationDuration = 0
-- Damit Fokus funktioniert: (?!?)
require 'action'
require 'profile'
local application = require "hs.application"
local fnutils = require "hs.fnutils"
local grid = require "hs.grid"
local hotkey = require "hs.hotkey"
local mjomatic = require "hs.mjomatic"
local window = require "hs.window"
local tiling = require "hs.tiling"
local main_monitor = "Color LCD"
local second_monitor = "VX24A"
----------------------------------------------
-- Configure Grid
----------------------------------------------
hs.grid.setMargins({0, 0})
hs.grid.setGrid('8x4','2560x1440')
hs.grid.setGrid('6x4')
hs.grid.ui.cellStrokeWidth = 0
hs.grid.ui.cellColor = {0,0,0,0.25}
hs.grid.ui.selectedColor = {0.925490,0.921569,0.921569,0.5}
hs.grid.ui.highlightColor = {0.8,0.8,0,0.5}
hs.grid.ui.textSize = 96
hs.grid.ui.fontName = 'TheSans'
hs.grid.ui.highlightStrokeWidth = 0
hs.grid.HINTS = {
  {'1', '2', '3', '4', '5', '6', '7', '8'},
  {'1', '2', '3', '4', '5', '6', '7', '8'},
  {'Q', 'W', 'E', 'R', 'T', 'Z', 'U', 'I'},
  {'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K'},
  {'Y', 'X', 'C', 'V', 'B', 'N', 'M', ','}
}
----------------------------------------------
-- Modifier shortcuts
----------------------------------------------
local hyper = {"cmd", "alt", "ctrl", "shift"}
local mash = {"cmd", "alt", "ctrl"}
local move = {"cmd", "alt"}
local tile = {"ctrl", "alt"}
-- hide window shadows
hs.window.setShadows(false)
----------------------------------------------
hs.hotkey.bind(move, 'left', hs.grid.pushWindowLeft)
hs.hotkey.bind(move, 'right', hs.grid.pushWindowRight)
hs.hotkey.bind(move, 'up', hs.grid.pushWindowUp)
hs.hotkey.bind(move, 'down', hs.grid.pushWindowDown)
-- resize windows
hs.hotkey.bind(hyper, 'up', hs.grid.resizeWindowShorter) -- nach oben
hs.hotkey.bind(hyper, 'down', hs.grid.resizeWindowTaller) -- nach unten
hs.hotkey.bind(hyper, 'left', hs.grid.resizeWindowThinner) -- nach links 
hs.hotkey.bind(hyper, 'right', hs.grid.resizeWindowWider) -- nach rechts
-- Show Grid
hs.hotkey.bind(mash, 'g',     function() hs.grid.toggleShow() end)
hs.hotkey.bind(mash, 'down',     function() hs.grid.toggleShow() end)
-- Snap single window to grid
hs.hotkey.bind(mash, ',',     function() grid.snap(window.focusedWindow()) end)
-- Snap all windows to grid
hs.hotkey.bind(hyper, ',',     function() fnutils.map(window.visibleWindows(), grid.snap) end)

---------------------------------------
-- Window Tiles: mash + U,D (Right, Left, Up, Down)
-- Left

hs.hotkey.bind(mash, "left", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
end)

-- Top

hs.hotkey.bind(mash, "U", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = 0
    f.y = 0
    f.w = max.w
    f.h = max.h / 2
    win:setFrame(f)
end)

-- Bottom

hs.hotkey.bind(mash, "D", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = 0
    f.y = max.y + (max.h / 2)
    f.w = max.w
    f.h = max.h / 2
    win:setFrame(f)
end)

-- Right

hs.hotkey.bind(mash, "right", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
end)

-- 1/3 Left

hs.hotkey.bind(hyper, "1", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = 0
    f.y = max.y
    f.w = (max.w / 3) * 2
    f.h = max.h
    win:setFrame(f)
end)

-- 2/3 Right

hs.hotkey.bind(hyper, "2", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = (max.w / 3) * 2
    f.y = max.y
    f.w = max.w / 3
    f.h = max.h
    win:setFrame(f)
end)

-- Fullscreen

hs.hotkey.bind(mash, "Up", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h
    win:setFrame(f)
end)

-----------------------------------------------
-- Special Positions
-----------------------------------------------

hs.hotkey.bind(mash, "4", function()
     local win = hs.window.focusedWindow()
     local f = win:frame()
     local screen = win:screen()
     local max = screen:frame()
 
     f.x = 145
     f.y = 0
     f.w = max.w - 280
     f.h = max.h
     win:setFrame(f)
end)
-- Center
hs.hotkey.bind(mash, "Space", function()
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen()
      local max = screen:frame()
 
      f.x = max.w / 8
      f.y = max.h / 12
      f.w = max.w * 0.75
      f.h = max.h * 0.85
      win:setFrame(f)
end)

-----------------------------------------------
-- Window Layouts
-----------------------------------------------

local function center(window)
	   frame = window:screen():frame()
	   frame.x = (frame.w / 2) - (frame.w / 4)
	   frame.y = (frame.h / 2) - (frame.h / 4)
	   frame.w = screen.w / 2
	   frame.h = screen.h / 2
	   window:setFrame(frame)
end

-- Float & Center

hotkey.bind(mash, "f", function() tiling.toggleFloat(center) end)

-- Cycle Layouts

hotkey.bind(mash, "c", function() tiling.cycleLayout() end)
hotkey.bind(mash, "v", function() tiling.cycle(1) end)
hotkey.bind(mash, "x", function() tiling.cycle(-1) end)	 

-----------------------------------------------
-- Mash + . to show window hints
-----------------------------------------------

hs.hotkey.bind(mash, ".", function()
    hs.hints.windowHints()
end)

----------------------------------------------
-- change focusWindowWest

hs.hotkey.bind(tile, 'Left', function() hs.window.focusedWindow():focusWindowWest() end)
hs.hotkey.bind(tile, 'Right', function() hs.window.focusedWindow():focusWindowEast() end)
hs.hotkey.bind(tile, 'Up', function() hs.window.focusedWindow():focusWindowNorth() end)
hs.hotkey.bind(tile, 'Down', function() hs.window.focusedWindow():focusWindowSouth() end)

-----------------------------------------------
-- Reload config on write
-----------------------------------------------

-- hotkey.bind(mash, "R", function() hs.reload() end)

function reload_config(files)
    hs.reload()
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reload_config):start()

hs.alert.show("Config loaded")