-- allSettings is a list of records containing {width:? height:? apps:{{name:? pos:? size:?},...}
-- for each display setup store the apps and their associated position and size
property allSettings: {}

-- create a variable for the current settings
set currentSettings to {}

--display dialog "Restore or save window settings?" buttons {"Restore", "Save"} default button "Restore"
--set dialogResult to result
set dialogResult to {button returned: "Save"}

tell application "Finder"

  -- use the desktop bounds to determine display config
  set desktopBounds to bounds of window of desktop
  set desktopWidth to item 3 of desktopBounds
  set desktopHeight to item 4 of desktopBounds
  set desktopResolution to desktopWidth & "x" & desktopHeight

  --	 find the saved settings for the display config
  --  log allSettings
  repeat with i from 1 to (count of allSettings)
    if (w of item i of allSettings is desktopWidth) and (h of item i of allSettings is desktopHeight) then
      set currentSettings to item i of allSettings
    end if
  end repeat

  if (count of currentSettings) is 0 then
  -- add the current display settings to the stored settings
    set currentSettings to {w:desktopWidth, h:desktopHeight, apps:{}}
    set end of allSettings to currentSettings
    --say "creating new config for " & desktopResolution
  else
  --say "found config for " & desktopResolution
  end if

end tell

log currentSettings


if (button returned of dialogResult is "Save") then
--  log "Saving"
  try
    tell application "System Events"
    log class of currentSettings
    log (get w of currentSettings) as text
    set configString to "{w:" & (get w of currentSettings) as text & ", h:" & (get h of currentSettings) as text & ", apps:" & "{"
    --set configString to "w:3840, h:1980, apps:"
      set isFirst to true
      repeat with proc in application processes where background only is false
        tell proc
          set procName to name of proc
          if (count of windows) > 0 then
            
            set appSize to size of window 1
            set appPosition to position of window 1

            set appConfigString to "{name:\"" & procName & "\", pos:{" & item 1 of appPosition & ", " & item 2 of appPosition & "}, size:{" & item 1 of appSize & ", " & item 2 of appSize & "}}"
            -- set appConfigString to "name:" & procName & ", size:" & item 1 of appSize & ", " & item 2 of appSize & ", pos:" & item 1 of appPosition & ", " & item 2 of appPosition

            if isFirst then
              set isFirst to false
              set configString to configString & appConfigString
            else
              set configString to configString & ", " & appConfigString
            end if
            
            -- Log human readable
            log procName
            log {size: appSize}
            log {position: appPosition}
            log ""
          else
            set appSize to {0}
            set appPosition to {0}
          end if
        end tell
      end repeat
      set configString to configString & "}}"
      log "Window Configuration String"
      log configString
      set target_file to (((path to home folder) as text) & ".dotfiles:macoscheats:windowSettings.txt")

      set the target_file to the target_file as text
      set the open_target_file to open for access file target_file with write permission
      set eof of the open_target_file to 0
      write configString to the open_target_file starting at eof
      close access the open_target_file

    end tell
  end try
end if
