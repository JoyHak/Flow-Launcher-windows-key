; Use some editor to open files

Editor 	        := IniRead(INI, "Global", "Editor", false)
EditorPath 	    := IniRead(INI, "Global", "EditorPath", "not exist")
EditorTitle     := "Use default &editor"
AddEditorTitle  := "Edit &default editor"

isApp(app) {
    ; Used for specific app, verb, name from PATH
    pid := -1
    try {    
        Run app, , "Hide", &pid
        
        ; ProcessWaitclose doesn't work...
        timer := 0
        while (timer <= 20 && !ProcessExist(pid)) {
            sleep 100
            timer++
        }
        ProcessClose(pid)
        return true
    } catch {
        return false
    }
}

AddEditor(inputError := "", *) {
    ; Display input, update configuration settings 
    ; if the user has selected OK and specified the valid app
    ; Repeat the request if the application is invalid and show inputError
    global INI, Editor, EditorPath
        
    input := InputBox(inputError " Enter the valid application path/name from PATH variable that will open files when Alt+Enter is pressed twice", 
                      inputError, , 
                      EditorPath)

    if input.result == "OK" {
        path := input.value
        if !(FileExist(path) || isApp(path)) {
            return AddEditor("Wrong app!")
        }
        ; Everything is valid, update globals
        Editor      := true
        EditorPath  := path
        TrayTip "The default application is selected", A_ScriptName
    } 
    ; Re-write current values or write updated values
    IniWrite(Editor,     INI, "Global", "Editor")
    IniWrite(EditorPath, INI, "Global", "EditorPath")	   
}

ValidateEditor() {
    global Editor, EditorPath, EditorTitle 
    
    if EditorPath == "not exist"
        AddEditor()
    
    if Editor
        A_TrayMenu.Check(EditorTitle)
    else 
        A_TrayMenu.UnCheck(EditorTitle)
}

EditorToggle(*) {
	global Editor

	Editor := !Editor
	IniWrite(Editor, INI, "Global", "Editor")
	ValidateEditor()
    reload
}

A_TrayMenu.Insert("4&", EditorTitle, EditorToggle, "Radio")
A_TrayMenu.Insert("5&", AddEditorTitle, AddEditor.bind(""), "Radio")
ValidateEditor()