##### The repository contains two scripts:

[Flow Hotkeys](https://github.com/JoyHak/Flow-Launcher-windows-key?tab=readme-ov-file#flowhotkeys): allows you to utilise the extended potential of your keyboard and Windows key! No more need to assign different hotkeys in PowerToys and memorise them: you can single, double press or hold a key. One shortcut - three actions! 

[ShowTargets](https://github.com/JoyHak/Flow-Launcher-windows-key?tab=readme-ov-file#showtargets): shows the menu that allows you to open the `.lnk/.url` target folder or open the folder where the file itself is located. Use the visual way of moving if you don't like hotkeys!

### FlowHotkeys

You no longer have to pull your fingers to `Ctrl` to open the folder where the file is stored. The handy combination `Alt+Enter` will help you:
- **Single-press:** open `.lnk` target folder *(folder where the program is located)*
- **Hold:**             open the folder where the file is located
![](https://github.com/JoyHak/Flow-Launcher-windows-key/blob/main/Images/FlowHotkey%20destination.gif)

If a non `.lnk` file is selected, both actions work the same way. So you can use single-press by default.

If you need to open the file in an editor (e.g. Notepad) or any other application, press `Alt+Enter` **twice**. You can change the application or disable this option in the `tray`.
![](https://github.com/JoyHak/Flow-Launcher-windows-key/blob/main/Images/FlowHotkeys%20editor.gif)

To use the Windows context menu, use `Shift+Enter` instead of `Alt+Enter`:
- **Single-press:** open Flow Launcher context menu
- **Twice:**            open Windows context menu
- **Hold:**             run as admin

Use the `Windows` key to open Flow Launcher.

- **Single-press:**  open Flow Launcher
- **Twice:** open settings
![](https://github.com/JoyHak/Flow-Launcher-windows-key/blob/main/Images/WinKey.gif)

To use shortcuts with the Windows key, you will have to hold it a little longer than usual *(300 ms)* until *“Win holded”* appears.<br/>
> **You can get around this limitation**. If you have any AHK script, add this line to the beginning:
> ```haskell
> ~LWin::SendEvent("{Blind}{vkFF}")
> ```
> **This line must be outside `Flow Hotkeys` and must not be imported with `#Include`!**<br/>
> <br/>
> Then replace https://github.com/JoyHak/Flow-Launcher-windows-key/blob/a89fca5b352daec6a19d5354b4bcca99317a1d9e/FlowHotkeys.ahk#L24 with:<br/>
> ```haskell
> FlowLauncher.add("LWin",  LWin_FlowLauncher,  "",,,, "~")
> ```
> <br/>
> You can also reduce the `tapTime` and `holdTime` values to speed up the keys. In this case you need to press twice very fast. 
>**`tapTime` should be at least 50ms less than `holdTime`!**
</br>
The script starts automatically after Windows Log-on. You can disable this option via the `Tray`.

### ShowTargets

If you are not comfortable using the keys, this menu allows to open the destination folder of the `.lnk` file or target url of the `.url` file; Also you can open the folder where the `.lnk` or `.url` file itself is located. 
![](https://github.com/JoyHak/Flow-Launcher-windows-key/blob/main/Images/ShowTargets.gif)
If another file is selected, the folder where the file is located will be opened. The menu is accessed by pressing `Alt+Enter`.

### Contribution

You can [suggest](https://github.com/JoyHak/Flow-Launcher-windows-key/issues/new/choose) new keys, improve the code or ask questions via [issues](https://github.com/JoyHak/Flow-Launcher-windows-key/issues/new/choose). I will be glad to see any suggestions for extending this script! Thanks to EvilC for the [TapHoldManager library](https://github.com/evilC/TapHoldManager).
