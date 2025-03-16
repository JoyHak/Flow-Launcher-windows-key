;@Ahk2Exe-Base C:\Program Files\AutoHotkey\v2\AutoHotkey32.exe, %A_ScriptDir%\Releases\%A_ScriptName~\.ahk%-x32.exe 
;@Ahk2Exe-Base C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe, %A_ScriptDir%\Releases\%A_ScriptName~\.ahk%-x64.exe 

;@Ahk2Exe-SetVersion %A_ScriptName~[^\d\.]+%
;@Ahk2Exe-SetMainIcon Libs\link.ico
;@Ahk2Exe-SetDescription Flow Launcher: use the visual way of moving if you don't like hotkeys!
;@Ahk2Exe-SetCopyright Rafaello
;@Ahk2Exe-SetLegalTrademarks GPL-3.0 license
;@Ahk2Exe-SetCompanyName ToYu studio

/*
    Show GUI with .lnk/.url targets
    By Rafaello: https://github.com/JoyHak/Flow-Launcher-windows-key?tab=readme-ov-file#showtargets
    GPL-3.0 license
*/  

#Requires AutoHotkey v2.0
#SingleInstance force
#Warn
;@Ahk2Exe-IgnoreBegin
TraySetIcon "Libs\link.ico"
;@Ahk2Exe-IgnoreEnd

SetTitleMatchMode 3  ; A window's title must exactly match WinTitle to be a match
#Include "Libs\Settings.ahk"
#Include "Libs\AutoDestroy.ahk"

#HotIf WinExist("ahk_exe Flow.Launcher.exe") && WinActive("Flow.Launcher ahk_exe Flow.Launcher.exe")
$!Enter::CheckClipboard

DeleteFileName(path) => SubStr(path, 1, InStr(path, "\" , , -1))

ClickLink(control, id, href) {
    global MsgLink
    Run href
    if AutoDestroyCurrent && IsSet(MsgLink)
        MsgLink.Destroy()
}

CheckClipboard(*) {    
    ; Save clipboard to restore later
    ClipSaved   := ClipboardAll()
    A_Clipboard := ""
    
    SendEvent "^+c"
    path := A_Clipboard
    
    ; Restore    
    A_Clipboard := ClipSaved
    ClipSaved   := ""

    extension := SubStr(path, -3)
    switch extension, "off" {    ; not case-sensitive
        case "lnk":
            target := ""       
            FileGetShortcut path, &target
    
            target  := DeleteFileName(target)
            path    := DeleteFileName(path)
            
        case "url":
            target  := IniRead(path, "InternetShortcut", "URL" , "URL not found!")
            path    := DeleteFileName(path)
        
        default:
            ; Open containing dir
            SendEvent "^{Enter}"
            Return
    } 
    
    if AutoDestroyOther && IsSet(MsgLink)
        MsgLink.Destroy()
    
    global MsgLink := Gui()
    MsgLink.SetFont("s14", "Tahoma")
    MsgLink.AddLink(, Format("Target:     <a href=`"{1}`">{1}</a>", target)).OnEvent("Click", ClickLink)
    MsgLink.AddLink(, Format("Directory:  <a href=`"{1}`">{1}</a>", path)).OnEvent("Click", ClickLink)
    
    MsgLink.Show()
}



