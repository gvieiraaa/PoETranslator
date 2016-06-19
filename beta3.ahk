
; == Startup Options ===========================================
#SingleInstance force
#NoEnv 
#Persistent ; Stay open in background
SendMode Input 
StringCaseSense, On ; Match strings with case.
Menu, tray, Tip, Tradutor PoE

If (A_AhkVersion <= "1.1.22")
{
    msgbox, You need AutoHotkey v1.1.22 or later to run this script. `n`nPlease go to http://ahkscript.org/download and download a recent version.
    exit
}

ArrayPT := Object()
ArrayEN := Object()
;Arraymax := Object()
ItemName := 1
FoundPT := 0
FoundEN := 0






;CARREGAR EN
ArrayCountEN = 0
Loop, Read, EN.txt
{
    ArrayENCount += 1
	ArrayEN%ArrayENCount% := A_LoopReadLine
}
ArrayCountPT = 0
;CARREGAR PT
Loop, Read, PT.txt
{
    ArrayPTCount += 1
	ArrayPT%ArrayPTCount% := A_LoopReadLine
}


;COMANDO PRINCIPAL
+t:: 
IfWinActive, Path of Exile ahk_class Direct3DWindowClass 
{
	GetItemName()
}
return

CoordMode, Mouse, Screen
CoordMode, ToolTip, Screen

ShowToolTip(conteudo)
{
    Sleep, 2
	Global xpos
    Global ypos
    MouseGetPos, xpos, ypos	
	gui, font, s18, Verdana 
    ToolTip, %conteudo%, xpos - 135, ypos + 30
    SetTimer, SubWatchCursor, 500    

}

SubWatchCursor:
  MouseGetPos, CurrX, CurrY
  MouseMoved := (CurrX - xpos)**2 + (CurrY - ypos)**2 > 45**2
  If (MouseMoved)
  {
 
    SetTimer, SubWatchCursor, Off
    ToolTip
  }
return

GetItemName() {
	IfWinActive, Path of Exile ahk_class Direct3DWindowClass
  {
    Send ^c
    Sleep 250
    ClipBoardData = %clipboard%
    Sleep 50
	StringSplit, data, ClipBoardData, `n, `r
	
	SegLinha = %data2%
	Controle = <<set:MS>><<set:M>><<set:S>>
	IfInString, SegLinha, %Controle%
	{
	StringTrimLeft, data2, data2, 28
	}
	ItemName = %data2%
	clipboard = %ItemName%
		loopEN:
		loop, 3020
		{
		  if (ArrayEN%A_Index% = data2) {
			ItemEN = % ArrayEN%A_Index%
			ItemPT = % ArrayPT%A_Index%
			FoundEN = 1
			break
		  }
		}
		
		
		loopPT:
		loop, 3020
		{
		  if (ArrayPT%A_Index% = data2) {
			ItemEN = % ArrayEN%A_Index%
			ItemPT = % ArrayPT%A_Index%
			FoundPT = 1
			break
			}
		}
		

if (FoundPT = 1 and FoundEN = 1)
	{
	clipboard = %ItemEN% Tem o mesmo nome em PT e EN.
	conteudo = %ItemEN% Tem o mesmo nome em PT e EN.
	ShowToolTip(conteudo)
	}
if (FoundPT = 1 and FoundEN != 1)
	{
	clipboard = %ItemPT% (PT) = %ItemEN% (EN)
	conteudo = %ItemPT% (PT) = %ItemEN% (EN)
	ShowToolTip(conteudo)
	}
if (FoundPT != 1 and FoundEN = 1)
	{
	clipboard = %ItemEN% (EN) = %ItemPT% (PT)
	conteudo = %ItemEN% (EN) = %ItemPT% (PT)
	ShowToolTip(conteudo)
	}
if (FoundPT != 1 and FoundEN != 1)
	{
	clipboard = %data2%: Item não encontrado
	conteudo = %data2%: Item não encontrado
	ShowToolTip(conteudo)
	}
}
}		





