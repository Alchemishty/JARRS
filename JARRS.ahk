#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

messageToggle := 0

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
}

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
    if (!messageToggle)	
	return

    SendRaw %rMessage%
Return

~Home::
    messageToggle := !messageToggle
    if(messageToggle) {
        msg("Message Toggle ON")
        SetTimer, LoopyLabel, 12000
    } else {
        msg("Message Toggle OFF")
        SetTimer, LoopyLabel, off
    }
return

~1::
 Send,
    (
	{Backspace}{Raw}%message1%

    )
return

~2::
 Send,
    (
	{Backspace}{Raw}%message2% 

    )
return

~3::
 SendInput,
    (
	{Backspace}{Raw}%message3%

    )
return
