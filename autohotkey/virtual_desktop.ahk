GetDesktopInfo()
{
  DesktopInfo := {}
  IdLength := 32
  DesktopInfo.CurrentId := RegRead("HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo\1\VirtualDesktops", "CurrentVirtualDesktop")
  if (DesktopInfo.CurrentId) {
    IdLength := StrLen(DesktopInfo.CurrentId)
  }
  DesktopList := RegRead( "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops","VirtualDesktopIDs")
  If (DesktopList) 
  {
    DesktopInfo.Count := StrLen(DesktopList) / IdLength
  } else
  {
    DesktopInfo.Count := 1
  }
  ; Windows indexes virtual desktops starting with 1. So stupid shit like this is needed
  DesktopInfo.CurrentIdx := (
    (InStr(DesktopList, DesktopInfo.CurrentId) - 1) / idLength +1
  )
  return DesktopInfo
}

SwitchToDesktop(targetIdx)
{
  desktopInfo := GetDesktopInfo()
  steps := targetIdx - desktopInfo.CurrentIdx
  WinActivate "ahk_class Shell_TrayWnd" ; Unfocus to prevent notification of applications
  Loop abs(steps)
  {
    if steps > 0 && desktopInfo.currentIdx == desktopInfo.Count 
      Send "#^d"
    Send "#^" . ((steps > 0) ? "{Right}" : "{Left}") 

    desktopInfo := GetDesktopInfo()
  }
}

SwitchToNextDesktop(direction)
{
  WinActivate "ahk_class Shell_TrayWnd"
  Send("#^{" . direction . "}")
}


MoveWindowToNextDesktop(direction)
{
  try
  {
    ActiveWindow := WinGetTitle("A")
  }
  catch as e
  {
    return
  }
  WinSetExStyle("^0x80", ActiveWindow)

  SwitchToNextDesktop(direction)
  sleep 50
  WinSetExStyle("^0x80", ActiveWindow)
  WinActivate ActiveWindow
}

MoveWindowToDesktop(targetIdx)
{
  try
  {
    ActiveWindow := WinGetTitle("A")
  } catch as e
  {
    return
  }
  WinSetExStyle("^0x80", ActiveWindow)
  SwitchToDesktop(targetIdx)
  sleep 50
  WinSetExStyle("^0x80", ActiveWindow)
  WinActivate ActiveWindow
}

SwitchToNextTile(direction)
{
  MouseGetPos ,,&id
  WinActivate "ahk_id " . id
  Send("#{Pg" . direction . "}")

}
