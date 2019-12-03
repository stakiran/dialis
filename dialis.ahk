; dialis - version 0.0.1

prepare:

; config
SetWorkingDir %A_ScriptDir%
CoordMode Menu, Screen
CoordMode Mouse, Screen
CoordMode Caret, Screen

; consts
EMBED_COUNTER_DELIM  := " | "
EMPTY_STRING_DISPLAY := "<Empty>"
SP = \
BASEDIR = %A_ScriptDir%
FILELIST_PATH := BASEDIR SP "filelist.txt"

; includes
#Include %A_ScriptDir%\libargument.ahk

; parsing_commandline_arguments
args := parse_arguments()

____main___:

main_preparation_for_menu:

list_fullpath := Object()
menuname_root := "menuname_root"
counter := new Counter()
; Because ahk is 1-origin.
counter.plus() 

try {
  Menu, %menuname_root%, DeleteAll
} catch e {
  ; absorb unavoidable failure because no menu at first time.
}

mein_construct_menu_with_loopreading:

; from filelist
Loop, Read, %FILELIST_PATH%
{
  fullpath := A_LoopReadLine

  itemname := fullpath
  curcount := counter.get()

  Menu, %menuname_root%, Add, %itemname% %EMBED_COUNTER_DELIM% %curcount%, label_do_after_select
  list_fullpath.Push(fullpath)
  counter.plus()
}

; system items
count_syscmd_edit := counter.get()
Menu, %menuname_root%, Add, <<Edit file list(&\)>> %EMBED_COUNTER_DELIM% %count_syscmd_edit%, label_do_after_select
list_fullpath.Push("__dummy__")
counter.plus()

main_display_menu:

posobj := determin_showpos()
showx := posobj.x
showy := posobj.y
Menu, %menuname_root%, Show, %showx%, %showy%
Return

____end_of_main____:

label_do_after_select:
selected_idx := get_menuitem_index_from_menuname(A_ThisMenuItem, EMBED_COUNTER_DELIM)
if(selected_idx==count_syscmd_edit){
  open_with_association(FILELIST_PATH)
  Return
}
selected_fullpath := list_fullpath[selected_idx]
copy_method(selected_fullpath)
paste_method()
; enter_method()
Return

funcs:
Return

enter_method(){
  Send,{Enter}
}

paste_method(){
  Send,^v
}

copy_method(fullpath){
  clipboard := fullpath
}

open_with_association(fullpath){
  Run, %fullpath%
}

determin_showpos(){
  ; Use the caret pos
  ; But if cannot get, use mouse cursor pos.
  pos := get_mouse_pos()
  pos.x := A_CaretX
  pos.y := A_CaretY
  Return pos
}

get_mouse_pos(){
  MouseGetPos, mousex, mousey

  mousepos := {}
  mousepos.x := mousex
  mousepos.y := mousey
  Return mousepos
}

get_menuitem_index_from_menuname(menuname, delim){
  ls := StrSplit(menuname, delim)
  Return ls[2]
}

is_empty_argument(arg){
  Return arg==""
}

is_not_empty_argument(arg){
  Return arg!=""
}

classes:
Return

class Counter {
  __New(){
    this._v := 0
  }

  plus(){
    curv := this._v
    newv := curv + 1
    this._v := newv
  }

  get(){
    Return this._v
  }
}
