; start gui stuff
#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%

Menu Tray, Icon, %A_ScriptDir%\tuto-icon.ico

Gui -MaximizeBox +AlwaysOnTop
Gui Color, 0x0080FF
Gui Add, Button, ggetset x192 y8 w104 h23, Fenster hinzufügen
Gui Add, Edit, x8 y8 w170 h21, Meinskript
Gui Add, Text, x8 y40 w463 h56, ...
Gui Add, Button, gfinish x392 y8 w80 h23, Fertigstellen

Gui Show, x1886 y92 w482 h113, TutoLayouter: Fenster samt Größe und Position wiederherstellen
Return

GuiEscape:
GuiClose:
    ExitApp
; end gui stuff 


; add window button actions
getset:
; get your typed name from the textbox
ControlGet, FensterDaten, Line, 1, Edit1
; get data from clicked window
KeyWait, LButton, D
WinGetTitle, Title, A
WinGetClass, Class, A
WinGet, Exe, ProcessName, A
WinGet, FullExe, ProcessPath, A
WinWait, %Title%
WinGetPos, X, Y, Width, Height, 
; lame OK-dialog so have something to do
MsgBox, %Title% wurde hinzugefügt. ; ... have been added
; write the script entry for the last clicked window 
FileAppend, ifWinNotExist ahk_exe %Exe%`n{Run`, %FullExe%`nWinWait`, ahk_class %Class%`nWinMove`, ahk_class %Class%`, `, %X%`, %Y%`, %Width%`, %Height%`n}`nelse`nWinMove`, ahk_class %Class%`, `, %X%`, %Y%`, %Width%`, %Height%`n`n`n,%FensterDaten%.ahk
; response in the GUI
;GuiControl, , ..., Hinzugefügt:`n%Title%
GuiControl, Text, Static1, %Title%
return

; finish button actions
finish:
; append final return and linebreak, reset texts in GUI 
FileAppend, return`n, %FensterDaten%.ahk
GuiControl, , Static1, Nächstes Projekt!
GuiControl, , Edit1, MeinNeuesSkript
return
