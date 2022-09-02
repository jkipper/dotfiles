
#SingleInstance force
#Include "virtual_desktop.ahk"

CapsLock::LCtrl

#t::
{
  if WinExist("ahk_exe WindowsTerminal.exe")
    WinActivate
  else 
    Run "wt.exe"
}

!a::ä
!+a::Ä
!o::ö
!+o::Ö
!u::ü
!+u::Ü
!s::ß
!k::Up
!j::Down
!h::Left
!l::Right

#<^1::
#<^2::
#<^3::
#<^4::
#<^5::
  switch_to_selected_desktop(PressedKey)
  {
    SwitchToDesktop(SubStr(PressedKey, -1))
  }

#+1::
#+2::
#+3::
#+4::
#+5::
  move_to_selected_desktop(PressedKey)
  {
    MoveWindowToDesktop(SubStr(PressedKey, -1))
  }

#+Right::
#+l::
{
  MoveWindowToNextDesktop("Right")
}
#+Left::
#+h::
{
  MoveWindowToNextDesktop("Left")
}

#^l::SwitchToNextDesktop("Right")
#^h::SwitchToNextDesktop("Left")

#HotIf MouseIsOn("ahk_class Shell_TrayWnd")
WheelUp::Send("#^{Left}")
WheelDown::Send("#^{Right}")
#HotIf

#WheelUp::SwitchToNextTile "Up"
#WheelDown::SwitchToNextTile "Dn"


MouseIsOn(WinTitle)  
{
  MouseGetPos ,,&id
  return WinExist(WinTitle . " ahk_id " id)
}

#!r::
{
  reload
}

