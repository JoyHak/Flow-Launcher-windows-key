##### The repository contains two scripts:

Flow Hotkeys: allows you to utilise the extended potential of your keyboard and Windows key! No more need to assign different hotkeys in PowerToys and memorise them: you can single, double press or hold a key. One shortcut - three actions! 

ShowTargets: shows the menu that allows you to open the `.lnk/.url` target folder or open the folder where the file itself is located. Use the visual way of moving if you don't like hotkeys!

### FlowHotkeys

#### Windows

Use the `Windows` key to open Flow Launcher:
**Single-press:** open Flow Launcher
**Twice:**            open settings

To use shortcuts with the Windows key, you will have to hold it a little longer than usual *(300 ms)* until *“Win holded”* appears.
> You can get around this limitation. If you have any AHK script, add it to the beginning:
> `~LWin::SendEvent("{Blind}{vkFF}")`
> **This line must be outside `Flow Hotkeys` and must not be imported with `#Include`!**
> Then replace this line in `Flow Hotkeys` with:
> `FlowLauncher.add("LWin",  LWin_FlowLauncher,  "",,,, "~")`
> 
> You can also reduce the `tapTime` and `holdTime` values to speed up the keys. In this case you need to press twice very fast. 
>**`tapTime` should be at least 50ms less than `holdTime`!**

#### Alt+Enter

You no longer have to pull your fingers to `Ctrl`  to open the folder where the file is stored. The handy combination `Alt+Enter` will help you:
**Single-press:** open `.lnk` target folder *(folder where the program is located)*
**Hold:**             open the folder where the file is located

If a non `.lnk` file is selected, both actions work the same way. So you can use single-press by default.

#### Editor

If you need to open the file in an editor (e.g. Notepad) or any other application, press `Alt+Enter` **twice**. You can change the application or disable this option in the `tray`.

To use the Windows context menu, use `Shift+Enter` instead of `Alt+Enter`:
**Single-press:** open Flow Launcher context menu
**Twice:**            open Windows context menu
**Hold:**             run as admin

### ShowTargets

If you are not comfortable using the keys, this menu allows to open the destination folder of the `.lnk` file or target url of the `.url` file; Also you can open the folder where the `.lnk` or `.url` file itself is located. If another file is selected, the folder where the file is located will be opened. The menu is accessed by pressing `Alt+Enter`.

### Contribution

You can suggest new keys, improve the code or ask questions via issues. I will be glad to see any suggestions for extending this script! Thanks to EvilC for the [TapHoldManager library](https://github.com/evilC/TapHoldManager).
