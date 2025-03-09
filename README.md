##### The repository contains two scripts:

[Flow Hotkeys](https://github.com/JoyHak/Flow-Launcher-windows-key?tab=readme-ov-file#flowhotkeys): allows you to utilise the extended potential of your keyboard and Windows key! No more need to assign different hotkeys in PowerToys and memorise them: you can single, double press or hold a key. One shortcut - three actions! 

[ShowTargets](https://github.com/JoyHak/Flow-Launcher-windows-key?tab=readme-ov-file#showtargets): shows the menu that allows you to open the `.lnk/.url` target folder or open the folder where the file itself is located. Use the visual way of moving if you don't like hotkeys!

### FlowHotkeys

You no longer have to pull your fingers to `Ctrl` to open the folder where the file is stored. The handy combination `Alt+Enter` will help you:
- **Single-press:** open `.lnk` target folder *(folder where the program is located)*
- **Hold:**             open the folder where the file is located
![](https://github.com/JoyHak/Flow-Launcher-windows-key/blob/main/Images/FlowHotkey%20destination.gif)

If a non `.lnk` file is selected, both actions work the same way. So you can use single-press by default.

If you need to open the file in an editor (e.g. Notepad) or any other application, press `Alt+Enter` **twice**. 
![](https://github.com/JoyHak/Flow-Launcher-windows-key/blob/main/Images/FlowHotkeys%20editor.gif)

You can change the application or disable this option in the `tray`, this will speed up the key response time. The key [will be considered held](https://github.com/JoyHak/Flow-Launcher-windows-key/blob/41819c7e9b639401d3d7f7c80d37e5a34a2284b4/Libs/TapHoldManager.ahk#L10) after *100ms* instead of *300ms*!

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

### ShowTargets

If you are not comfortable using the keys, this menu allows to open the destination folder of the `.lnk` file or target url of the `.url` file; Also you can open the folder where the `.lnk` or `.url` file itself is located. 
![](https://github.com/JoyHak/Flow-Launcher-windows-key/blob/main/Images/ShowTargets.gif)
If another file is selected, the folder where the file is located will be opened. The menu is accessed by pressing `Alt+Enter`. The behavior of current and previous menus can be changed in `Tray`. For example, you can leave the menu after clicking a link.

### Installation

1. [Download](https://github.com/JoyHak/Flow-Launcher-windows-key/releases) the latest version.

> [Subscribe to releases](https://docs.github.com/en/account-and-profile/managing-subscriptions-and-notifications-on-github/setting-up-notifications/about-notifications#notifications-and-subscriptions) so you don't miss critical updates!

2. Run `.exe` for your CPU architecture and check it's existence in the tray.

3. The script starts automatically after Windows Log-on. You can disable this option via the `Tray`.

### Contribution

You can [suggest](https://github.com/JoyHak/Flow-Launcher-windows-key/issues/new/choose) new keys, improve the code or ask questions via [issues](https://github.com/JoyHak/Flow-Launcher-windows-key/issues/new/choose). I will be glad to see any suggestions for extending this script! Thanks to EvilC for the [TapHoldManager library](https://github.com/evilC/TapHoldManager).

### Scripting

This script is written in the [Autohotkey language](https://en.m.wikipedia.org/wiki/AutoHotkey).

1. [Download](https://www.autohotkey.com/download/) stable Autohotkey v2 and install it. 

2. When the installation is complete, you are presented with another menu. Choose `Run AutoHotkey`.
Once the AutoHotkey help file opens, you can read or close it now. 

3. [Download](https://github.com/JoyHak/Flow-Launcher-windows-key/releases) the latest version of required archive.

4.  Unpack `.zip` and run `.ahk`. Check it's existence in the tray.

### Compiling	

Scripts can be automatically compiled using `ahk2exe` which is here by default: `C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe` ([download from here](https://github.com/AutoHotkey/Ahk2Exe)). Or install from here: `C:\Program Files\AutoHotkey\UX\install-ahk2exe.ahk`

`7-zip` is also needed to automatically create an archive with the required files: 

```powershell
"C:\Program Files\7-Zip\7zG.exe" a "%A_ScriptDir%\Releases\QuickSwitch 1.0".zip -tzip -sae -- "%A_ScriptDir%\QuickSwitch.ahk" "%A_ScriptDir%\Libs" "%A_ScriptDir%\QuickSwitch.ico"
```

For compilation, you need to select the .exe AHK v2 with Unicode support. They can be found here:
```powershell
C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe
C:\Program Files\AutoHotkey\v2\AutoHotkey32.exe
```

[Directives](https://www.autohotkey.com/docs/v2/misc/Ahk2ExeDirectives.htm) are used for compilation, but it can be set manually at each compilation using the `ahk2exe GUI`. But this is inconvenient because you will need to manually perform different actions each time you run it and you lose [the benefits of directives](https://www.autohotkey.com/docs/v2/misc/Ahk2ExeDirectives.htm#SetProp):

> Script compiler directives allow the user to specify details of how a script is to be compiled via [Ahk2Exe](https://www.autohotkey.com/docs/v2/Scripts.htm#ahk2exe). Some of the features are:
>
> - Ability to change the version information (such as the name, description, version...).
> - Ability to add resources to the compiled script.
> - Ability to tweak several miscellaneous aspects of compilation.
> - Ability to remove code sections from the compiled script and vice versa.
