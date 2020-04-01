#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Event  ; SendMode Event so we can control SetKeyDelay
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2  ; Check that the given string matches somewhere in the window title
SetKeyDelay, 15  ; Feels a little more human. Fast, but not too fast.

messageToggle := False
isKeyActive := False
recruitMessageOn := "Recruit Message ON"
recruitMessageOff := "Recruit Message OFF"

; Read in the Recruiting Message text file
FileRead, rMessage, Recruiting Message.txt

; Read in each message in the Auto Messages text file
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

; Loop to check if current window is the targeted active window.
;SetTimer,Loop1,900
;return
;Loop1:
;  IfWinNotActive, Untitled - Notepad
;  {
;   messageToggle := False
;   msg(recruitMessageOff)
;   return
;  }
;  Return

; Print a tooltip to notify if the recruit message loop is active. Hotkeys for auto-replies will remain active.
Msg(s)
{
    ToolTip, %s%, 140, 140
    SetTimer, RemoveToolTip, 2000
    return
}

; Remove tooltip message after a delay
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

    ; Make sure the active window is correct before sending input
    IfWinNotActive, Untitled - Notepad
    {
        messageToggle := False
        msg(recruitMessageOff)
        return
    }

    ; Send the recruit message
    ;BlockInput, On
    SendRaw %rMessage%
    ;BlockInput, Off
Return

; Press Home key to toggle the message on and off
Home::
    messageToggle := !messageToggle
    
    if(messageToggle) {
        msg(recruitMessageOn)
        SetTimer, LoopyLabel, 12100 ; Send the recruit message every 121 sec
    } else {
        msg(recruitMessageOff)
        SetTimer, LoopyLabel, off
    }
return

; Press the Pause/Break key to suspend the script and hotkeys (i.e. turn it off without quitting)
~Pause::
    Suspend, Toggle
    messageToggle := !messageToggle
    msg(recruitMessageOff)
return

; Send Message 1
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

; Send Message 2
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

; Send Message 3
^3::
    if(messageToggle) {
        messageToggle := False
        msg(recruitMessageOff)
    }
    Send,
        (
        {Raw}%message3%

        )
return

; Send Message 4
^4::
    if(messageToggle) {
        messageToggle := False
        msg(recruitMessageOff)
    }
    Send,
        (
        {Raw}%message4%

        )
return

; Send Message 5
^5::
    if(messageToggle) {
        messageToggle := False
        msg(recruitMessageOff)
    }
    Send,
        (
        {Raw}%message5%

        )
return

; Open the Key
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