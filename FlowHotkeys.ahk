/*
    Remap some Flow Launcher keys
    By Rafaello: https://github.com/JoyHak
    GPL-3.0 license
*/

#Requires AutoHotkey v2.0
#SingleInstance force
#Warn
TraySetIcon "Libs\win.ico"

#Include "Libs\TapHoldManager.ahk"
#Include "Libs\Settings.ahk"
#Include "Libs\Editor.ahk"
Hotkey "^Esc", (*) => ExitApp

/*
╭────────────✧⭑────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
|	Flow launcher
╰───•✧⭑─────⭑─────────────────── ✧.·:·.*───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
*/

FlowLauncher := TapHoldManager("ahk_exe Flow.Launcher.exe",,,, "$")
FlowLauncher.add("LWin",  	LWin_FlowLauncher,  "") 
FlowLauncher.add("+Enter",  Shift_Enter_FlowLauncher)

if Editor {
    FlowLauncher.add("!Enter",  Alt_Enter_Run_FlowLauncher)
} else {
    ; Decrease tapTime to speed-up hotkey
    FlowLauncher.add("!Enter",  Alt_Enter_FlowLauncher,, 50,100)
}

LWin_FlowLauncher(taps, state) {
    SendEvent "{LWin up}"
    if state == -1 {    ; TAP
        if taps == 1 {
            ; Open flow launcher
            SendEvent "!{space}"
        } else if taps == 2 && WinActive("ahk_exe Flow.Launcher.exe") {
            ; Settings
            SendEvent "^i"
        }
    } else if state {   ; HOLD
        ; Reserved for windows shortcuts
        ShowTooltip("Win holded")
        SendEvent "{LWin down}"
    }
}

Shift_Enter_FlowLauncher(taps, state) {
    if state == -1 {    ; TAP
        if taps == 1 {
            ; Native context menu
            SendEvent "+{Enter}"
        } else if taps == 2 {
            ; Win context menu
            SendEvent "!{Enter}"
        }
    } else if state {	; HOLD
        ; Run as admin
        SendEvent "^+{Enter}"
    }
}

Alt_Enter_Run_FlowLauncher(taps, state) {
    global EditorPath
    
    if state == -1 {    ; TAP
        if taps == 1 {
            OpenTarget()
        } else if taps == 2 {
            try {
                Run EditorPath ' `"' GetFlowLauncherPath() '`"'
            } catch {
                AddEditor("Cannot open the file using specifed app!")
            }
        }
    } else if state {	; HOLD
        SendEvent "^{Enter}"
    }
}

Alt_Enter_FlowLauncher(taps, state) {
    global EditorPath
    
    if state == -1 {    ; TAP
        OpenTarget()
    } else if state {	; HOLD
        SendEvent "^{Enter}"
    }
}

GetFlowLauncherPath() {
    ; Save clipboard to restore later
    ClipSaved   := ClipboardAll()
    A_Clipboard := ""

    SendEvent "^+c"
    path := A_Clipboard

    ; Restore
    A_Clipboard := ClipSaved
    ClipSaved   := ""

    return path
}

OpenTarget() {
    path := GetFlowLauncherPath()
    extension := SubStr(path, -3)

    if extension == "lnk" {
        ; Open target dir
        target := ""
        FileGetShortcut path, &target

        ; Delete name.exe from target path
        target := SubStr(target, 1, InStr(target, "\" , , -1))
        Run target
    } else {
        ; Open containing dir
        SendEvent "^{Enter}"
    }
}