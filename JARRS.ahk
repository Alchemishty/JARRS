#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

messageToggle := 0

FileRead, rMessage, Recruiting Message.txt
FileRead, aMessage1, Auto Message 1.txt 
FileRead, aMessage2, Auto Message 2.txt 
FileRead, aMessage3, Auto Message 3.txt 

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
 SendInput,
    (
	{Backspace}SendRaw %aMessage1%

    )
return

~2::
 SendInput,
    (
	{Backspace}SendRaw %aMessage2%

    )
return

~3::
 SendInput,
    (
	{Backspace}SendRaw %aMessage3%

    )
return
