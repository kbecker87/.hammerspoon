-----------------------------------------------
-- Hammerspoon 30.3.17
-----------------------------------------------
hs.window.animationDuration = 0
-- Damit Fokus funktioniert: (?!?)
require 'action'
require 'profile'
require 'launcher'
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
hs.grid.setGrid('8x4')
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
-- hs.window.setShadows(false)
----------------------------------------------
hs.hotkey.bind(move, 'left', hs.grid.pushWindowLeft)
hs.hotkey.bind(move, 'right', hs.grid.pushWindowRight)
hs.hotkey.bind(move, 'up', hs.grid.pushWindowUp)
hs.hotkey.bind(move, 'down', hs.grid.pushWindowDown)
-- resize windows
hs.hotkey.bind(tile, 'up', hs.grid.resizeWindowShorter) -- nach oben
hs.hotkey.bind(tile, 'down', hs.grid.resizeWindowTaller) -- nach unten
hs.hotkey.bind(tile, 'left', hs.grid.resizeWindowThinner) -- nach links 
hs.hotkey.bind(tile, 'right', hs.grid.resizeWindowWider) -- nach rechts
-- Show Grid
hs.hotkey.bind(mash, 'down',     function() hs.grid.toggleShow() end)
-- Snap focused window to grid
hs.hotkey.bind(mash, ',',     function() grid.snap(window.focusedWindow()) end)
--------------------------------------- 
tabModMode = hs.hotkey.modal.new()

tabModMode:bind({}, 's', function() hs.application.launchOrFocus("Safari") end)
tabModMode:bind({}, 't', function() hs.application.launchOrFocus("Sublime Text") end)
    
tabMod = hs.hotkey.bind({}, "tab",
  function()
    tabModMode:enter()
    tabModMode.triggered = false
  end,
  function()
    tabModMode:exit()
    if not tabModMode.triggered then
      tabMod:disable()
      hs.eventtap.keyStroke({}, "tab")
      tabMod:enable()
    end
  end
)       
-- Apps launchen: 
-- hs.hotkey.bind(tab, 's', function() hs.application.launchOrFocus("Safari") end)

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

-- 2/3 Left

hs.hotkey.bind(hyper, "Q", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.x = 0
    f.y = max.y
    f.w = (max.w / 6) * 4
    f.h = max.h
    win:setFrame(f)
end)

-- 1/3 Right

hs.hotkey.bind(hyper, "W", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = (max.w / 6) * 4
    f.y = max.y
    f.w = (max.w / 6) * 2
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
      local max = win:screen():frame()
 
      f.x = max.x + (max.w / 8)
      f.y = max.y + (max.h / 12)
      f.w = max.w * 0.75
      f.h = max.h * 0.85
      win:setFrame(f)
end)

-----------------------------------------------
-- Window Layouts
-----------------------------------------------

local function center(window)
	   frame = window:screen():frame()
	   frame.x = max.x + ((frame.w / 2) - (frame.w / 4))
	   frame.y = (frame.h / 2) - (frame.h / 4)
	   frame.w = screen.w / 2
	   frame.h = screen.h / 2
	   window:setFrame(frame)
end

-- Float & Center

-- weg? hotkey.bind(mash, "f", function() tiling.toggleFloat(center) end)

-- Cycle Layouts

hotkey.bind(mash, "l", function() tiling.cycleLayout() end)
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

hs.hotkey.bind(hyper, 'Left', function() hs.window.focusedWindow():focusWindowWest() end)
hs.hotkey.bind(hyper, 'Right', function() hs.window.focusedWindow():focusWindowEast() end)
hs.hotkey.bind(hyper, 'Up', function() hs.window.focusedWindow():focusWindowNorth() end)
hs.hotkey.bind(hyper, 'Down', function() hs.window.focusedWindow():focusWindowSouth() end)

----------------------------------------------
-- Layouts je App

local layouts = {
  {
    name = {"PDF Expert"},
    func = function(index, win)
    local screen = win:screen()
      local max = screen:frame()
      local f = win:frame()
      f.x = max.x + (max.w / 6)
      f.y = max.y
      f.w = (max.w / 6) * 4 
      f.h = max.h
      win:setFrame(f)
    end
  },
  {
    name = {"Evernote"},
    func = function(index, win)
    local screen = win:screen()
      local max = screen:frame()
      local f = win:frame()
      f.x = max.x + (max.w / 6)
      f.y = max.y
      f.w = (max.w / 6) * 4 
      f.h = max.h
      win:setFrame(f)
    end
  },
  {
    name = {"TaskPaper"},
    func = function(index, win)
      local f = win:frame()
      local screen = win:screen()
      local max = screen:frame()
      f.x = max.x + (max.w / 4)
      f.y = 0
      f.h = max.h
      f.w = (max.w / 6) * 3 
      win:setFrame(f)
    end
  },
  {
    name = {"Quiver"},
    func = function(index, win)
    local screen = win:screen()
      local max = screen:frame()
      local f = win:frame()
      f.x = max.x + (max.w / 6)
      f.y = max.y
      f.w = (max.w / 6) * 4 
      f.h = max.h
      win:setFrame(f)
    end
  },
  {
    name = {"Path Finder"},
    func = function(index, win)
    local screen = win:screen()
      local max = screen:frame()
      local f = win:frame()
      f.x = max.x + (0)
      f.y = max.y
      f.w = (max.w / 6) * 3 
      f.h = (max.h / 4) * 1.5
      win:setFrame(f)
    end
  },
  {
    name = {"Dictionary"},
    func = function(index, win)
    local screen = win:screen()
      local max = screen:frame()
      local f = win:frame()
      f.x = max.x + (0)
      f.y = max.y
      f.w = max.w / 4 
      f.h = (max.h / 4) * 3
      win:setFrame(f)
    end
  },  
  {
    name = {"Sublime Text"},
    func = function(index, win)
    local screen = win:screen()
      local max = screen:frame()
      local f = win:frame()
      f.x = max.x + (max.w / 4)
      f.y = 0
      f.h = max.h
      f.w = (max.w / 6) * 3 
      win:setFrame(f)
    end
  },
  {
    name = {"Typora"},
    func = function(index, win)
    local screen = win:screen()
      local max = screen:frame()
      local f = win:frame()
      f.x = max.x + (max.w / 4)
      f.y = 0
      f.h = max.h
      f.w = (max.w / 6) * 3 
      win:setFrame(f)
    end
  },
  {
    name = {"Scrivener"},
    func = function(index, win)
    local screen = win:screen()
      local max = screen:frame()
      local f = win:frame()
      f.x = max.x + (max.w / 4)
      f.y = 0
      f.h = max.h
      f.w = (max.w / 6) * 3 
      win:setFrame(f)
    end
  },
  {
    name = {"nvALT"},
    func = function(index, win)
    local screen = win:screen()
      local max = screen:frame()
      local f = win:frame()
      f.x = max.x + (max.w / 8)
      f.y = 0
      f.h = (max.h / 4) * 3
      f.w = max.w / 4 
      win:setFrame(f)
    end
  },
  {
    name = {"iTerm2"},
    func = function(index, win)
    local screen = win:screen()
      local max = screen:frame()
      local f = win:frame()
      f.x = max.x + (max.w / 4)
      f.y = max.w / 30
      f.h = (max.h / 4) * 1.5
      f.w = (max.w / 6) * 3 
      win:setFrame(f)
    end
  },
  {
    name = {"Telegram"},
    func = function(index, win)
    local screen = win:screen()
      local max = screen:frame()
      local f = win:frame()
      f.x = max.x + (0)
      f.y = max.y
      f.h = (max.h / 4) * 2
      f.w = max.w / 6 
      win:setFrame(f)
    end
  },
  {
    name = {"WhatsApp"},
    func = function(index, win)
    local screen = win:screen()
      local max = screen:frame()
      local f = win:frame()
      f.x = max.x + (max.w / 2)
      f.y = max.y
      f.h = (max.h / 4) * 2
      f.w = max.w / 2 
      win:setFrame(f)
    end
  },
  {
    name = {"Reminders"},
    func = function(index, win)
    local screen = win:screen()
      local max = screen:frame()
      local f = win:frame()
      f.x = max.x + (0)
      f.y = max.y
      f.h = (max.h / 4) * 2
      f.w = (max.w / 6) * 1 
      win:setFrame(f)
    end
  },
}

----------------------------------------------
-- Layouts (Apps) Hotkey

hs.hotkey.bind(mash, "n", function()
  local focusedWindow = hs.window.focusedWindow()
  local app = focusedWindow:application()
  if (app) then
    applyLayout(layouts, app)
  end
  end)

--------------------------------------------------------------------------------
-- METHODS für die Layout-Funktion - Lassen!
--------------------------------------------------------------------------------
function applyLayout(layouts, app)
  if (app) then
    local appName = app:title()

    for i, layout in ipairs(layouts) do
      if (type(layout.name) == "table") then
        for i, layAppName in ipairs(layout.name) do
          if (layAppName == appName) then
            hs.alert.show(appName)
          
            local wins = app:allWindows()
            local counter = 1
            for j, win in ipairs(wins) do
              if (win:isVisible() and layout.func) then
                layout.func(counter, win)
                counter = counter + 1
              end
            end
          end
        end
      elseif (type(layout.name) == "string") then
        if (layout.name == appName) then
          local wins = app:allWindows()
          local counter = 1
          for j, win in ipairs(wins) do
            if (win:isVisible() and layout.func) then
              layout.func(counter, win)
              counter = counter + 1
            end
          end
        end
      end
    end
  end
end

-----------------------------------------------
-- Reload config on write
-----------------------------------------------

function reloadConfig(files)
  local doReload = false
  for _,file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
    hs.alert.show('Config Reloaded')
  end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

-- Manueller Reload:
hs.hotkey.bind(mash, "r", function()
  hs.reload()
end)
hs.alert.show("Config loaded")
