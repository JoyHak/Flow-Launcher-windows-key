;@Ahk2Exe-Base C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe, %A_ScriptDir%\Releases\%A_ScriptName~\.ahk%-x64.exe 
;@Ahk2Exe-Base C:\Program Files\AutoHotkey\v2\AutoHotkey32.exe, %A_ScriptDir%\Releases\%A_ScriptName~\.ahk%-x32.exe 

;@Ahk2Exe-SetVersion %A_ScriptName~[^\d\.]+%
;@Ahk2Exe-SetMainIcon Libs\win.ico
;@Ahk2Exe-SetDescription Flow Launcher: single/double press or hold a hotkey. One hotkey - three actions
;@Ahk2Exe-SetCopyright Rafaello
;@Ahk2Exe-SetLegalTrademarks GPL-3.0 license
;@Ahk2Exe-SetCompanyName ToYu studio

/*
    Remap some Flow Launcher keys
    By Rafaello: https://github.com/JoyHak/Flow-Launcher-windows-key
    GPL-3.0 license
*/

#Requires AutoHotkey v2.0
#SingleInstance force
#Warn
;@Ahk2Exe-IgnoreBegin
TraySetIcon "Libs\win.ico"
;@Ahk2Exe-IgnoreEnd
SetTitleMatchMode 3  ; A window's title must exactly match WinTitle to be a match

#Include "Libs\TapHoldManager.ahk"
#Include "Libs\Settings.ahk"
#Include "Libs\Editor.ahk"

/*
╭────────────✧⭑────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
|	Flow launcher
╰───•✧⭑─────⭑─────────────────── ✧.·:·.*───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
*/

FlowLauncher := TapHoldManager("Flow.Launcher ahk_exe Flow.Launcher.exe",,,, "$")
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