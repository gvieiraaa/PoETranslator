;===============================================================
;================= PoE Tradutor EN/PT - PT/EN ==================
;===============================================================
;================= Criado por Gustavo Vieira ===================
;===============================================================
;======= [ www.facebook.com/groups/poebrasiloficial ] ==========
;===============================================================
;===============================================================
;======= Crédito para partes do código para exiletools =========
;================= [ http://exiletools.com ] ===================
;===============================================================
;==== [ Github: https://github.com/gvieiraaa/PoETranslator ] ===
;===============================================================
;===============================================================

; == Startup Options ===========================================
#SingleInstance force
#NoEnv 
#Persistent ; Stay open in background
SendMode Input 
StringCaseSense, On ; Match strings with case.
#MaxThreadsPerHotkey 2
Menu, tray, Tip, Tradutor PoE


;===============================================================
;================= [ Setting the language ] ====================
;====== [ Use "BR" for portuguese and "RU" for Russian ] =======
;===============================================================
Global Language := "BR"
;===============================================================
;===============================================================
;===============================================================


If (A_AhkVersion <= "1.1.22" AND Language = "BR")
{
    msgbox, Você precisa da versão do AutoHotkey v1.1.22 ou superior para rodar esse script. `n`nPor favor vá até http://ahkscript.org/download e baixe a última versão.
    exit
}

If (A_AhkVersion <= "1.1.22" AND Language = "RU")
{
    msgbox, Вам нужна версия AutoHotkey v1.1.22 или выше для запуска этого скрипта. `n`nПожалуйста, перейдите на http://ahkscript.org/download и скачайте последнюю версию.
    exit
}

ArrayPT := Object()
ArrayEN := Object()
ArrayRU := Object()
Global Arraymax := 0
ItemName := 1
FoundPT := 0
FoundEN := 0
FoundRU := 0

;CARREGAR EN
ArrayCountEN = 0
Loop, Read, EN.txt
{
    ArrayENCount += 1
	Arraymax = %ArrayENCount%
	ArrayEN%ArrayENCount% := A_LoopReadLine
}

;CARREGAR PT
ArrayCountPT = 0
Loop, Read, PT.txt
{
    ArrayPTCount += 1
	Arraymax = %ArrayPTCount%
	ArrayPT%ArrayPTCount% := A_LoopReadLine
}

;CARREGAR RU
ArrayCountRU = 0
Loop, Read, RU.txt
{
    ArrayRUCount += 1
	Arraymax = %ArrayRUCount%
	ArrayRU%ArrayRUCount% := A_LoopReadLine
}


;COMANDO PRINCIPAL
#IfWinActive, Path of Exile ahk_class POEWindowClass
+y:: 
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
	
if (Language = "BR" or Language = "PT")
{
		loopEN:
		loop, %Arraymax%
		{
		  if (ArrayEN%A_Index% = data2) {
			ItemEN = % ArrayEN%A_Index%
			ItemPT = % ArrayPT%A_Index%
			FoundEN = 1
			break
		  }
		}
		
		loopPT:
		loop, %Arraymax%
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
	clipboard = %ItemEN% Tem o mesmo nome em PT e EN. [Script em tiny.cc/tradutor]
	conteudo = %ItemEN% Tem o mesmo nome em PT e EN.
	ShowToolTip(conteudo)
	}
if (FoundPT = 1 and FoundEN != 1)
	{
	clipboard = %ItemPT% (PT) = %ItemEN% (EN) [Script em tiny.cc/tradutor]
	conteudo = %ItemPT% (PT) = %ItemEN% (EN)
	ShowToolTip(conteudo)
	}
if (FoundPT != 1 and FoundEN = 1)
	{
	clipboard = %ItemEN% (EN) = %ItemPT% (PT) [Script em tiny.cc/tradutor]
	conteudo = %ItemEN% (EN) = %ItemPT% (PT)
	ShowToolTip(conteudo)
	}
if (FoundPT != 1 and FoundEN != 1)
	{
	clipboard = %data2%: Item não encontrado [Script em tiny.cc/tradutor]
	conteudo = %data2%: Item não encontrado
	ShowToolTip(conteudo)
	}
}

if (Language = "RU")
{
		loopENRU:
		loop, %Arraymax%
		{
		  if (ArrayEN%A_Index% = data2) {
			ItemEN = % ArrayEN%A_Index%
			ItemRU = % ArrayRU%A_Index%
			FoundEN = 1
			break
		  }
		}
		
		loopRU:
		loop, %Arraymax%
		{
		  if (ArrayRU%A_Index% = data2) {
			ItemEN = % ArrayEN%A_Index%
			ItemRU = % ArrayRU%A_Index%
			FoundRU = 1
			break
			}
		}
		

if (FoundRU = 1 and FoundEN = 1)
	{
	clipboard = %ItemEN% имеет то же имя на английском и русском. [Cкрипт в tiny.cc/tradutor]
	conteudo = %ItemEN% имеет то же имя на английском и русском.
	ShowToolTip(conteudo)
	}
if (FoundRU = 1 and FoundEN != 1)
	{
	clipboard = %ItemRU% (RU) = %ItemEN% (EN) [Cкриптв tiny.cc/tradutor]
	conteudo = %ItemRU% (RU) = %ItemEN% (EN)
	ShowToolTip(conteudo)
	}
if (FoundRU != 1 and FoundEN = 1)
	{
	clipboard = %ItemEN% (EN) = %ItemRU% (RU) [Cкрипт в tiny.cc/tradutor]
	conteudo = %ItemEN% (EN) = %ItemRU% (RU)
	ShowToolTip(conteudo)
	}
if (FoundRU != 1 and FoundEN != 1)
	{
	clipboard = %data2%: предмет не найден [Cкрипт в tiny.cc/tradutor]
	conteudo = %data2%: предмет не найден
	ShowToolTip(conteudo)
	}
}

}


}
