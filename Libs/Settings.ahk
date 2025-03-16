command(FuncObj, *) {
	if (WinActive("ahk_class Notepad++")) {
		FuncObj.call()		
	}	
}
Hotkey "~^s",  command.bind(Reload)
Hotkey "^Esc", command.bind(ExitApp)

; Setup configuration .ini file
ScriptName := ""
ConfigDir  := "Config"

SplitPath A_ScriptFullPath, , , , &ScriptName
INI := ConfigDir "\" ScriptName ".ini"

if !DirExist(ConfigDir)
	DirCreate ConfigDir
if !FileExist(INI)
	FileAppend "", INI
ScriptName := ""

/*
╭────────────✧⭑────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
|	Keys history (for Win testing)
╰───•✧⭑─────⭑─────────────────── ✧.·:·.*───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
*/

History 	 := IniRead(INI, "Global", "KeyHistory", false)
HistoryTitle := "&Enable KeyHistory"

ShowHistory(*) {
	global History

	if History
		KeyHistory
	else
		TrayTip "KeyHistory disabled", A_ScriptName, "Icon!"
}

ValidateHistory() {
	global History

	if History {
		A_TrayMenu.Check(HistoryTitle)
		KeyHistory 500
	} else {
		A_TrayMenu.UnCheck(HistoryTitle)
		KeyHistory 0
	}
}

HistoryToggle(*) {
	global History

	History := !History
	IniWrite(History, INI, "Global", "KeyHistory")
	ValidateHistory()
}

A_TrayMenu.Insert("1&", "Show KeyHistory", 	 ShowHistory)
A_TrayMenu.Insert("1&", HistoryTitle, 		 HistoryToggle, 	"Radio")
ValidateHistory()

/*
╭────────────✧⭑────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
|	AutoStartup
╰───•✧⭑─────⭑─────────────────── ✧.·:·.*───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
*/

AutoStartup 	 := IniRead(INI, "Global", "AutoStartup", true)
AutoStartupTitle := "Enable &AutoStartup"

ValidateAutoStartup() {
	global AutoStartup
	
    nameNoExtension := SubStr(A_ScriptName, 1, -4)
    ; Delete version and CPU architecture
    nameClean := RegExReplace(nameNoExtension, "-x?(32|64)|-\d+\.\d+(.\d+)?")
	mask := A_Startup "\" nameClean "*"	
    link := A_Startup "\" nameNoExtension ".lnk"

	if AutoStartup {
		A_TrayMenu.Check(AutoStartupTitle)
		if !FileExist(link) {
            ; Clear every possible script instances from Startup dir
            FileDelete(mask)
			FileCreateShortcut(A_ScriptFullPath, link, A_WorkingDir)
			TrayTip "AutoStartup enabled", A_ScriptName
		}
	} else {
		A_TrayMenu.UnCheck(AutoStartupTitle)
		FileDelete(mask)
		TrayTip "AutoStartup disabled", A_ScriptName, "Icon!"
	}
}

AutoStartupToggle(*) {
	global AutoStartup
	
	AutoStartup := !AutoStartup	
	IniWrite(AutoStartup, INI, "Global", "AutoStartup")	
	ValidateAutoStartup()
}

A_TrayMenu.Insert("1&", AutoStartupTitle, AutoStartupToggle, "Radio")
ValidateAutoStartup()

/*
╭────────────✧⭑────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
|	Functions
╰───•✧⭑─────⭑─────────────────── ✧.·:·.*───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
*/

ShowTooltip(text) {
	ToolTip Format("{}", text)
    SetTimer ToolTip, -2000
}

ShowHotkey(taps, state) {
    ; Show key, info about action

    ; hold press => "HOLD (time)"; single press => "TAP"
	action := state == -1 ? "TAP" : Format("HOLD ({}ms)", A_TimeSincePriorHotkey)

    stats := Format("{} `n {} `n Taps: {} `n State: {}",
					 A_PriorHotkey, action, taps, state)

    ShowTooltip(stats)
    sleep 2000
}