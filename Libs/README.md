# TapHoldManager: fork

Original: https://github.com/evilC/TapHoldManager

The purpose of each script in this folder is documented in its header. The scripts are documented by comments. 
**Keys**:        https://www.autohotkey.com/docs/v2/KeyList.htm
**Prefixes**:  https://www.autohotkey.com/docs/v2/Hotkeys.htm

#### Create new manager

```haskell
app := TapHoldManager([window, tapTime, holdTime, maxTaps, prefixes])
```

1. ##### window  

  A string [WinTitle](https://www.autohotkey.com/docs/v2/misc/WinTitle.htm) that defines in which windows the hotkey will be active.    

2. ##### tapTime 

  The amount of time after a press during which to wait for another press. *Default is 200 ms*.

3. ##### holdTime 

  The amount of time the button must be held for it to be considered held. *Default is 300 ms*.

4. ##### maxTaps     

  The maximum number of taps to process (the maximum number of calls to the function assigned to the key).

5. ##### prefix      

  The [prefix](https://www.autohotkey.com/docs/v2/Hotkeys.htm) used for all hotkeys, default is none. It's necessary to minimize the use of hooks in scripts, as written in [this article](https://www.autohotkey.com/boards/viewtopic.php?f=96&t=127074&p=562131&hilit=Hook+custom+combination#p562131)! Use [SendEvent](https://www.autohotkey.com/docs/v2/lib/Send.htm#SendEvent) if prefix is used.

#### Add a button

```lua
app.add(key, function, [window, tapTime, holdTime, maxTaps, prefix])
```

1. ##### key

   Standard syntax: key/key combination. Acceptable options: [HotKey](https://www.autohotkey.com/docs/v2/lib/Hotkey.htm). A custom combination `Mod & Key` is also allowed, [however, the prefix $ cannot be used with it](https://www.autohotkey.com/docs/v2/Hotkeys.htm#combo). Since it is set by default, it **must be overridden!**

2. ##### function

   The name of the function **without parameters**. It must be declared.

Optionally, for each key, you can override `window, tapTime, holdTime, maxTaps, prefixes`

#### Assigning Actions to Keys

Each key (tilde, back, forw...) corresponds to a function (action). Its name has the form `Key_Application` or `Modifier_Key_Application`:  `Tilde_BrowseApps, LAlt_Back_BrowseApps`...

```lua
Tilde_AllApps(taps, state) {
	if state==-1 {    ; Just press
		if taps==1 {		; single press
			SendInput "{Blind}{Delete}"        
		} else if taps==2 {	; press twice
			SendInput "{Blind}{Backspace}"
		} 
	} else if state { ; Press and Hold
		SendInput "{Enter}"
	}	
}
```

If the key is held `state==1`, if it is released afterwards `state==0`
If the key is just pressed `state==-1`.

Regardless of the `state` parameter, the `taps` parameter always holds the number of presses (always `taps>=1`).

```lua
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
```

