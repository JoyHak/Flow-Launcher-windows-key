/*
╭────────────✧⭑────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
|	Globals
|   thats why I dont like CamelCase...
╰───•✧⭑─────⭑─────────────────── ✧.·:·.*───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
*/

AutoDestroyCurrent 	    := IniRead(INI, "Global", "AutoDestroyCurrent", true)
AutoDestroyOther 	    := IniRead(INI, "Global", "AutoDestroyOther", false)
AutoDestroyCurrentTitle := "Hide after &click"
AutoDestroyOtherTitle   := "Hide &old menus"

/*
╭────────────✧⭑────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
|	Toggle tray menu
╰───•✧⭑─────⭑─────────────────── ✧.·:·.*───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
*/

ValidateAutoDestroyCurrent() {
	global AutoDestroyCurrent

	if AutoDestroyCurrent
		A_TrayMenu.Check(AutoDestroyCurrentTitle)
	else
		A_TrayMenu.UnCheck(AutoDestroyCurrentTitle)
}

ValidateAutoDestroyOther() {
	global AutoDestroyOther

	if AutoDestroyOther
		A_TrayMenu.Check(AutoDestroyOtherTitle)
	else 
		A_TrayMenu.UnCheck(AutoDestroyOtherTitle)
}

/*
╭────────────✧⭑────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
|	Change and write values
╰───•✧⭑─────⭑─────────────────── ✧.·:·.*───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
*/

AutoDestroyCurrentToggle(*) {
	global AutoDestroyCurrent

	AutoDestroyCurrent := !AutoDestroyCurrent
	IniWrite(AutoDestroyCurrent, INI, "Global", "AutoDestroyCurrent")
	ValidateAutoDestroyCurrent()
    
    if AutoDestroyCurrent
        TrayTip "The menu will disappear after clicking on the link", A_ScriptName
	else
        TrayTip "The menu will remain after clicking on the link", A_ScriptName, "Iconi"
}

AutoDestroyOtherToggle(*) {
	global AutoDestroyOther

	AutoDestroyOther := !AutoDestroyOther
	IniWrite(AutoDestroyOther, INI, "Global", "AutoDestroyOther")
	ValidateAutoDestroyOther()
    
    if AutoDestroyOther
        TrayTip "Once the new menu is started, the old menus will disappear", A_ScriptName
	else
        TrayTip "The previous menus will remain on the screen", A_ScriptName, "Iconi"
}

/*
╭────────────✧⭑────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
|	Setup tray menu and init validators
╰───•✧⭑─────⭑─────────────────── ✧.·:·.*───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
*/

A_TrayMenu.Insert("3&", AutoDestroyCurrentTitle, AutoDestroyCurrentToggle, "Radio")
A_TrayMenu.Insert("4&", AutoDestroyOtherTitle, AutoDestroyOtherToggle, "Radio")

ValidateAutoDestroyCurrent()
ValidateAutoDestroyOther()