# dialis
Enforce windows file dialog('open' and 'save as') with showing a popup-menu from your filelist.txt

## Overview
![dialis_demo](https://user-images.githubusercontent.com/23325839/70042641-93954380-1602-11ea-9c88-12f37b9e1b40.gif)

dialis is a popup menu based file path copy tool.

- 1: Push scroll lock key in a file dialog.
  - :memo: Of course, the key you use can be changed.
- 2: A poup menu is opend, so select one what you open.
- 3: Copypasted with your selection.

## Requirement
- AutoHotkey Version 1.1.30+

## Install
At first, get.

```
$ git clone https://github.com/stakiran/dialis
```

If needed, build and get an dialis.exe.

```
$ git clone https://github.com/stakiran/dialis
$ cd dialis
$ copy build.ahk.sample build.ahk
$ (Edit build.ahk based on your environment)
$ build.ahk
```

Set an commandline to call the dialis from your ahk script. For example...

Example1: Use an exe file and ScrollLock key.

```ahk
#If WinActive("ahk_class #32770")
ScrollLock::run, D:\bin\dialis\dialis.exe
#If
```

Example2: Use an script and ScrollLock key.

```ahk
#If WinActive("ahk_class #32770")
ScrollLock::run, D:\bin\dialis\dialis.ahk
#If
```

## License
[MIT License](LICENSE)

## Author
[stakiran](https://github.com/stakiran)
