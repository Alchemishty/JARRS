#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

messageToggle := False
isKeyActive := False
recruitMessageOn := "Recruit Message ON"
recruitMessageOff := "Recruit Message OFF"

FileRead, rMessage, Recruiting Message.txt

Loop, read, Auto Messages.txt
{
    if InStr(A_LoopReadLine, "Message1:") {
        RegExMatch(A_LoopReadLine, "O)Message1:(.+)", Message1)
	message1 := Message1.value(1)
    }

    if InStr(A_LoopReadLine, "Message2:") {
        RegExMatch(A_LoopReadLine, "O)Message2:(.+)", Message2)
	message2 := Message2.value(1)
    }

    if InStr(A_LoopReadLine, "Message3:") {
        RegExMatch(A_LoopReadLine, "O)Message3:(.+)", Message3)
	message3 := Message3.value(1)
    }

    if InStr(A_LoopReadLine, "Message4:") {
        RegExMatch(A_LoopReadLine, "O)Message4:(.+)", Message4)
	message4 := Message4.value(1)
    }

    if InStr(A_LoopReadLine, "Message5:") {
        RegExMatch(A_LoopReadLine, "O)Message5:(.+)", Message5)
	message5 := Message5.value(1)
    }
}

SetTimer,Loop1,900
return
Loop1:
  IfWinNotActive, Untitled - Notepad
  {
   messageToggle := False
   msg(recruitMessageOff)
   return
  }
  Return

Msg(s)
{
    ToolTip, %s%, 140, 140
    SetTimer, RemoveToolTip, 2000
    return
}

RemoveToolTip:
{
    SetTimer, RemoveToolTip, Off
    ToolTip
    ;return
}

LoopyLabel:
    if (!messageToggle)	{ ; I like this solution to the loop problem.
	    return
    }
    SendRaw %rMessage%
Return

~Home::
    messageToggle := !messageToggle
    
    if(messageToggle) {
        msg(recruitMessageOn)
        SetTimer, LoopyLabel, 12000
    } else {
        msg(recruitMessageOff)
        SetTimer, LoopyLabel, off
    }
return

~Pause::Pause

^1::
if(messageToggle) {
    messageToggle := False
    msg(recruitMessageOff)
}
 Send,
    (
	{Raw}%message1%
    
    )
return

^2::
if(messageToggle) {
    messageToggle := False
    msg(recruitMessageOff)
}
 Send,
    (
	{Raw}%message2% 
    
    )
return

^3::
if(messageToggle) {
    messageToggle := False
    msg(recruitMessageOff)
}
 SendInput,
    (
	{Raw}%message3%

    )
return

^4::
if(messageToggle) {
    messageToggle := False
    msg(recruitMessageOff)
}
 SendInput,
    (
	{Raw}%message4%

    )
return

^5::
if(messageToggle) {
    messageToggle := False
    msg(recruitMessageOff)
}
 SendInput,
    (
	{Raw}%message5%

    )
return

^K::
    isKeyActive := !isKeyActive
    
    if(isKeyActive) {
        Gui, Add, Text, x12 y9 , Message1: %message1%
	Gui, Add, Text, x12 y39 , Message2: %message2%
	Gui, Add, Text, x12 y69 , Message3: %message3%
	Gui, Add, Text, x12 y99 , Message4: %message4%
	Gui, Add, Text, x12 y129 , Message5: %message5%
	Gui, Show, AutoSize Center
	Gui, +AlwaysOnTop
	Return
    } else {
        Gui, Destroy
    }
return