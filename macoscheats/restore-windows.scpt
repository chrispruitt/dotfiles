-- allSettings is a list of records containing {width:? height:? apps:{{name:? pos:? size:?},...}
-- for each display setup store the apps and their associated position and size
property allSettings: {}

-- create a variable for the current settings
set currentSettings to {w:3840, h:1980, apps:{{name:"Notes", pos:{-1919, 23}, size:{1241, 754}}, {name:"Finder", pos:{-1919, 23}, size:{600, 600}}, {name:"iTerm2", pos:{-1140, 206}, size:{1040, 673}}, {name:"Slack", pos:{-1244, 1103}, size:{1152, 846}}, {name:"Atom", pos:{-1799, 90}, size:{1657, 954}}, {name:"Messages", pos:{-1292, 1271}, size:{1011, 663}}, {name:"Google Chrome", pos:{2129, 20}, size:{1552, 915}}, {name:"Postman", pos:{-1702, 36}, size:{1552, 915}}, {name:"idea", pos:{0, 23}, size:{1920, 1057}}}}

--display dialog "Restore or save window settings?" buttons {"Restore", "Save"} default button "Restore"
--set dialogResult to result
set dialogResult to {button returned: "Restore"}

--tell application "Finder"
--
--  -- use the desktop bounds to determine display config
--  set desktopBounds to bounds of window of desktop
--  set desktopWidth to item 3 of desktopBounds
--  set desktopHeight to item 4 of desktopBounds
--  set desktopResolution to desktopWidth & "x" & desktopHeight
--
--  --	 find the saved settings for the display config
--  --  log allSettings
--  repeat with i from 1 to (count of allSettings)
--    if (w of item i of allSettings is desktopWidth) and (h of item i of allSettings is desktopHeight) then
--      set currentSettings to item i of allSettings
--    end if
--  end repeat
--
--  if (count of currentSettings) is 0 then
--  -- add the current display settings to the stored settings
--    set currentSettings to {w:desktopWidth, h:desktopHeight, apps:{}}
--    set end of allSettings to currentSettings
--    --say "creating new config for " & desktopResolution
--  else
--  --say "found config for " & desktopResolution
--  end if
--
--end tell
--
--
--if (button returned of dialogResult is "Save") then
--  log "Saving"
--  try
--    tell application "System Events"
--      repeat with proc in application processes where background only is false
--        tell proc
--          set procName to name of proc
--          if (count of windows) > 0 then
--            log "Found window for: " & procName
--            set appSize to size of window 1
--            set appPosition to position of window 1
--            log {size: appSize}
--            log {position: appPosition}
--          else
--            set appSize to {0}
--            set appPosition to {0}
--          end if
--          set appSettings to {}
--
--          repeat with i from 1 to (count of apps of currentSettings)
--            if name of item i of apps of currentSettings is procName then
--             set appSettings to item i of apps of currentSettings
--            end if
--          end repeat
--
--          if (count of appSettings) is 0 then
--            set appSettings to {name:procName, pos:appPosition, size:appSize}
--            set end of apps of currentSettings to appSettings
--          else
--            set pos of appSettings to appPosition
--            set size of appSettings to appSize
--          end if
--        end tell
--      end repeat
--    end tell
--  end try
--end if

if (button returned of dialogResult is "Restore") then
  if (count of apps of currentSettings) is 0 then
    say "no window settings were found"
  else
  --			say "restoring"
    log "Restoring..."
    repeat with i from 1 to (count of apps of currentSettings)
      set appSettings to item i of apps of currentSettings
      set appName to (name of appSettings as string)
      try
        tell application "System Events"
          repeat with proc in application processes where name is appName
            tell proc
              log appName
              if name is appName then
                repeat with win in windows
                  set position of win to pos of appSettings
                  set size of win to size of appSettings
                end repeat
              end if
            end tell
          end repeat
        end tell
      end try
    end repeat
    log "Done."
  end if
end if
