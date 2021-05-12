-- allSettings is a list of records containing {width:? height:? apps:{{name:? pos:? size:?},...}
-- for each display setup store the apps and their associated position and size
property allSettings: {}

-- read from configuration file
--set target_file to (((path to home folder) as text) & ".dotfiles:macoscheats:windowSettings.txt")
--set windowSettings to read file target_file

-- todo, use window settings from file - need to include width and height when writing
--log windowSettings
--log class of windowSettings

-- create a variable for the current settings
set currentSettings to {w:4153, h:1980, apps:{{name:"Keybase", pos:{-1920, 0}, size:{960, 600}}, {name:"firefox", pos:{1920, 0}}, {name:"Google Chrome", pos:{1920, 0}, size:{1920, 1080}}, {name:"Slack", pos:{-960, 0}, size:{960, 1080}}, {name:"iTerm2", pos:{-1920, 0}, size:{960, 540}}, {name:"Typora", pos:{-1920, 0}, size:{960, 1080}}, {name:"Electron", pos:{0, 25}, size:{1920, 1055}}, {name:"Calendar", pos:{-1920, 449}, size:{960, 631}}, {name:"Finder", pos:{1951, 401}, size:{968, 545}}, {name:"idea", pos:{0, 25}, size:{1920, 1055}}}}

--display dialog "Restore or save window settings?" buttons {"Restore", "Save"} default button "Restore"
--set dialogResult to result
set dialogResult to {button returned: "Restore"}



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
