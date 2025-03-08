/*
    Show GUI with .lnk/.url targets
    By Rafaello: https://github.com/JoyHak
    GPL-3.0 license
*/

#Requires AutoHotkey v2.0
#SingleInstance force
#Warn

#Include "Libs\Settings.ahk"
TraySetIcon "Libs\link.ico"

ClickLink(control, id, href) {
    global MsgLink
    Run href
    MsgLink.Destroy()
}

DeleteFileName(path) => SubStr(path, 1, InStr(path, "\" , , -1))

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
    
    global MsgLink := Gui()
    MsgLink.SetFont("s14", "Tahoma")
    MsgLink.AddLink(, Format("Target:     <a href=`"{1}`">{1}</a>", target)).OnEvent("Click", ClickLink)
    MsgLink.AddLink(, Format("Directory:  <a href=`"{1}`">{1}</a>", path)).OnEvent("Click", ClickLink)
    
    MsgLink.Show()
    

    

}

#HotIf WinExist("ahk_exe Flow.Launcher.exe")
#HotIf WinActive("ahk_exe Flow.Launcher.exe")
Hotkey "$!Enter", CheckClipboard



