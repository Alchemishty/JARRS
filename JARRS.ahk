#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Event  ; SendMode Event so we can control SetKeyDelay
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2  ; Check that the given string matches somewhere in the window title
SetKeyDelay, 15  ; Feels a little more human. Fast, but not too fast.


messageToggle := False
isKeyActive := False
macroStart := False
recruitMessageOn := "Recruit Message ON"
recruitMessageOff := "Recruit Message OFF"
status := "OFF"

Rand(min,max) {
    Random, randomNumber, min, max
    return randomNumber
}

; Set a random key delay.
RandomKeyDelay() {
    SetKeyDelay, % Rand(15,30)
    return
}

; Check if the script is being run as admin.
; This is required to prevent the user from typing or clicking around while input is being sent
full_command_line := DllCall("GetCommandLine", "str")

if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    try
    {
        if A_IsCompiled
            Run *RunAs "%A_ScriptFullPath%" /restart
        else
            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
    }
    ExitApp
}
; MsgBox A_IsAdmin: %A_IsAdmin%`nCommand line: %full_command_line%


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


;Loop to check if recruiting message is on and update GUI status accordingly
SetTimer,Loop1,500
return
Loop1:
  if (messageToggle) 
  {
    status := "ON"
  }
  else
  {
    status := "OFF"
  }
  GuiControl, , Tvar, Macro is %status%
  Return


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
    ; IfWinNotActive, Untitled - Notepad
    IfWinNotActive, Warframe
    {
        messageToggle := False
        msg(recruitMessageOff)
        return
    }

    ; Send the recruit message
    BlockInput, On
    RandomKeyDelay()
    SendRaw %rMessage%
    BlockInput, Off
Return

; Press Home key to toggle the message on and off
~^=::
    messageToggle := !messageToggle
    macroStart := !macroStart
    
    if (messageToggle) {
        msg(recruitMessageOn)
        SetTimer, LoopyLabel, 121000 ; Send the recruit message every 121 sec
    }
    else {
        msg(recruitMessageOff)
        SetTimer, LoopyLabel, off
    }
return


; Press the Pause/Break key to suspend the script and hotkeys (i.e. turn it off without quitting)
~^-::
    Suspend, Toggle
    ; Pause, Toggle ; Can be one or the other. Both prevents starting the script again.

    if (macroStart) {
        messageToggle := !messageToggle
        if (!messageToggle) {
            msg(recruitMessageOff)
            SetTimer, LoopyLabel, off
        }
        else {
            msg(recruitMessageOn)
            SetTimer, LoopyLabel, 12100
        }
    }
return


; Send Message 1
^1::
    if (messageToggle) {
        messageToggle := False
        msg(recruitMessageOff)
    }
    BlockInput, On
    RandomKeyDelay()
    Send,
        (
        {Raw}%message1%
        
        )
    BlockInput, Off
return

; Send Message 2
^2::
    if (messageToggle) {
        messageToggle := False
        msg(recruitMessageOff)
    }
    BlockInput, On
    RandomKeyDelay()
    Send,
        (
        {Raw}%message2% 
        
        )
    BlockInput, Off
return

; Send Message 3
^3::
    if (messageToggle) {
        messageToggle := False
        msg(recruitMessageOff)
    }
    BlockInput, On
    RandomKeyDelay()
    Send,
        (
        {Raw}%message3%

        )
    BlockInput, Off
return

; Send Message 4
^4::
    if (messageToggle) {
        messageToggle := False
        msg(recruitMessageOff)
    }
    BlockInput, On
    RandomKeyDelay()
    Send,
        (
        {Raw}%message4%

        )
    BlockInput, Off
return

; Send Message 5
^5::
    if (messageToggle) {
        messageToggle := False
        msg(recruitMessageOff)
    }
    BlockInput, On
    RandomKeyDelay()
    Send,
        (
        {Raw}%message5%

        )
    BlockInput, Off
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
	    Gui, Add, Text, x12 y159 vTvar, Macro is %status%
	    Gui, Show, NoActivate AutoSize, Recruiting Auto-Replies
	    Gui, +AlwaysOnTop
        ; Move the window to the top-right of the screen
        WinGetPos,,, Width, Height, Recruiting Auto-Replies
        WinMove, Recruiting Auto-Replies,, (A_ScreenWidth - Width - 25), 25
	Return
    } else {
        Gui, Destroy
    }
return