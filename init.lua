-----------------------------------------------
-- Hammerspoon Karl 3.9.16
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
local move = {"alt", "ctrl"}
-- local size = {"ctrl", "cmd"}
local push = {"alt", "cmd"}
local mash = {"cmd", "alt", "ctrl"}
-- hide window shadows
hs.window.setShadows(false)
----------------------------------------------

-- Show Grid
hs.hotkey.bind(mash, 'g',     function() hs.grid.toggleShow() end)
hs.hotkey.bind(mash, 'down',     function() hs.grid.toggleShow() end)
-- Snap single window to grid
hs.hotkey.bind(mash, ',',     function() grid.snap(window.focusedWindow()) end)
-- Snap all windows to grid
hs.hotkey.bind(mash, '.',     function() fnutils.map(window.visibleWindows(), grid.snap) end)

-- --------------------------------------------------------

-- --------------------------------------------------------
-- Helper function to resize
-- --------------------------------------------------------

-- Resize a window by moving the bottom
function yank(xpixels,ypixels)
	local win = hs.window.focusedWindow()
	local f = win:frame()

	f.w = f.w + xpixels
	f.h = f.h + ypixels
	win:setFrame(f)
end

----------------------------------------------
-- Movement hotkeys

-- Im Grid
-- hs.hotkey.bind(move, 'down', function() grid.pushWindowDown() end)   --down
-- hs.hotkey.bind(move, "up", function() grid.pushWindowUp() end) --up
-- hs.hotkey.bind(move, "right", function() grid.pushWindowRight() end) --right
-- hs.hotkey.bind(move, "left", function() grid.pushWindowLeft() end) --left

-- Um jeweils 100px
-- hs.hotkey.bind(move, 'down', function() nudge(0,100) end)   --down
-- hs.hotkey.bind(move, "up", function() nudge(0,-100) end)  --up
-- hs.hotkey.bind(move, "right", function() nudge(100,0) end)  --right
-- hs.hotkey.bind(move, "left", function() nudge(-100,0) end)  --left

-- Resize hotkeys

-- Um jeweils 100px
-- hs.hotkey.bind(size, "up", function() yank(0,-100) end) -- yank bottom up
-- hs.hotkey.bind(size, "down", function() yank(0,100) end) -- yank bottom down
-- hs.hotkey.bind(size, "right", function() yank(100,0) end) -- yank right side right
-- hs.hotkey.bind(size, "left", function() yank(-100,0) end) -- yank right side left

---------------------------------------
-- Left

hs.hotkey.bind({"ctrl", "alt"}, "Left", function()
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

hs.hotkey.bind({"ctrl", "alt"}, "Up", function()
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

hs.hotkey.bind({"ctrl", "alt"}, "Down", function()
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

hs.hotkey.bind({"ctrl", "alt"}, "Right", function()
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

hs.hotkey.bind({"ctrl", "alt", "cmd"}, "Left", function()
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

hs.hotkey.bind({"ctrl", "alt", "cmd"}, "right", function()
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

hs.hotkey.bind({"ctrl", "alt", "cmd"}, "Up", function()
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
-- Hyper i to show window hints
-----------------------------------------------

hs.hotkey.bind(hyper, "i", function()
    hs.hints.windowHints()
end)

----------------------------------------------
-- change focusWindowWest

hs.hotkey.bind(hyper, 'Left', function() hs.window.focusedWindow():focusWindowWest() end)
hs.hotkey.bind(hyper, 'Right', function() hs.window.focusedWindow():focusWindowEast() end)
hs.hotkey.bind(hyper, 'Up', function() hs.window.focusedWindow():focusWindowNorth() end)
hs.hotkey.bind(hyper, 'Down', function() hs.window.focusedWindow():focusWindowSouth() end)

----------------------------------------------
-- Launch or Focus Safari & Canary (Mail)

hs.hotkey.bind(mash, "b", function() hs.application.launchOrFocus("Safari") end)
hs.hotkey.bind(mash, "m", function() hs.application.launchOrFocus("Canary") end)

-----------------------------------------------
-- Reload config on write
-----------------------------------------------

hotkey.bind(mash, "R", function()
  hs.reload()
end)

function reload_config(files)
    hs.reload()
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reload_config):start()

hs.alert.show("Config loaded")