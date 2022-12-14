; ctrl+capslock to show text case change menu 
SetWorkingDir %A_ScriptDir%
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance force
#NoTrayIcon
#Include %A_ScriptDir%\node_modules
#Include morse.ahk\export.ahk
#Include %A_ScriptDir%\Dynamic Expressions.ahk
#Include %A_ScriptDir%\icons

ExprInit()

GroupAdd All

uxtheme := DllCall("GetModuleHandle", "str", "uxtheme", "ptr")
SetPreferredAppMode := DllCall("GetProcAddress", "ptr", uxtheme, "ptr", 135, "ptr")
FlushMenuThemes := DllCall("GetProcAddress", "ptr", uxtheme, "ptr", 136, "ptr")
DllCall(SetPreferredAppMode, "int", 1) ; Dark
DllCall(FlushMenuThemes)

Menu Case, Add, &UPPERCASE, CCase ; 1
Menu Case, Add, &lowercase, CCase ; 2
Menu Case, Add, &Title Case, CCase ; 3
Menu Case, Add ; 4  -----> Line Break
Menu Case, Add, &aLt cApS case, CCase ; 5
Menu Case, Add, &Stop. Case., CCase ; 6
Menu Case, Add, &Reverse, CCase ; 7
Menu Case, Add ; 8  -----> Line Break
Menu Utilities, Add, &Morse, MenuHandler ; 1
Menu Utilities, Add, &Un-Morse, MenuHandler ; 2
Menu Utilities, Add, &Calculate, MenuHandler ; 3
Menu Utilities, Add, &Translate, MenuHandler ; 4
Menu Utilities, Add, &Subscript Numbers, MenuHandler ;5
Menu Case, Add, Utilities, :Utilities ; 9

Menu, Case, Icon, &UPPERCASE, icons\upperwhite.png,, 0
Menu, Case, Icon, &lowercase, icons\lowerwhite.png,, 0
Menu, Case, Icon, &Title Case, icons\titlewhite.png,, 0
Menu, Case, Icon, &Reverse, icons\reversewhite.png,, 0
Menu, Case, Icon, &aLt cApS case, icons\alternatewhite.png,, 0
Menu, Case, Icon, &Stop. Case., icons\periodwhite.png,, 0
Menu, Case, Icon, Utilities, icons\utilitieswhite.png,, 0
Menu, Utilities, Icon, &Morse, icons\morse-codewhite.png,, 0
Menu, Utilities, Icon, &Un-Morse, icons\englishwhite.png,, 0
Menu, Utilities, Icon, &Calculate, icons\calculator.png,, 0
Menu, Utilities, Icon, &Translate, icons\translate.png,, 0
Menu, Utilities, Icon, &Subscript Numbers, icons\subnumbers.png,, 0

^CapsLock::
   GetText(TempText)
   If NOT ERRORLEVEL
      Menu Case, Show
Return

CCase:
   If (A_ThisMenuItemPos = 1)
   {
      StringUpper, TempText, TempText
      PutText(TempText)
   }
   Else If (A_ThisMenuItemPos = 2)
   {
      StringLower, TempText, TempText
      PutText(TempText)
   }
   Else If (A_ThisMenuItemPos = 3)
   {
      StringLower, TempText, TempText, T
      PutText(TempText)
   }
   Else If (A_ThisMenuItemPos = 5)
   {
      result := ""
      Loop, Parse, % TempText
         result .= Format("{1:" (Mod(A_Index, 2) = 0 ? "U" : "L") "}", A_LoopField)
      TempText := result
      PutText(TempText)
   }
   Else if (A_ThisMenuItemPos = 6)
   {
      TempText := RegExReplace(TempText, "[ ]", ". ")
      PutText(TempText)
   }
   Else If (A_ThisMenuItemPos = 7)
   {
      Temp2 =
      StringReplace, TempText, TempText, `r`n, % Chr(29), All
      Loop Parse, TempText
         Temp2 := A_LoopField . Temp2
      StringReplace, TempText, Temp2, % Chr(29), `r`n, All
      PutText(TempText)
   }
Return

MenuHandler:
   If (A_ThisMenuItemPos = 1)
   {
      morse := new morse()
      result := morse.encode(TempText)
      TempText := result
      PutText(TempText)
   }
   Else If (A_ThisMenuItemPos = 2)
   {
      global result2
      morse := new morse()
      result2 := morse.decode(TempText)
      MsgBox, 0,, %result2%
   }
   Else If (A_ThisMenuItemPos = 3)
   {
      CompiledExpression := ExprCompile(TempText)
      TempText := ExprEval(CompiledExpression)
      PutText(TempText)
   }
   Else If (A_ThisMenuItemPos = 4)
   {
      run, https://translate.google.com/?sl=auto&tl=en&text=%TempText%&op=translate
   }
   Else If (A_ThisMenuItemPos = 5)
   {
      If (P=0) OR (P=)
      {
         res := SubRevert(TempText)
         P=1
         PutText(res)
      }
      Else
      {
         res := SubConvert(TempText)
         P=0
         PutText(res)
      }
   }
Return

; Handy function.
; Copies the selected text to a variable while preserving the clipboard.
GetText(ByRef MyText = "")
{
   SavedClip := ClipboardAll
   Clipboard =
   Send ^c
   ClipWait 0.5
   If ERRORLEVEL
   {
      Clipboard := SavedClip
      MyText =
      Return
   }
   MyText := Clipboard
   Clipboard := SavedClip
Return MyText
}
Return

; Pastes text from a variable while preserving the clipboard.
PutText(MyText)
{
   SavedClip := ClipboardAll 
   Clipboard = ; For better compatability
   Sleep 20 ; with Clipboard History
   Clipboard := MyText
   Send ^v
   Sleep 100
   Clipboard := SavedClip
Return
}

SubRevert(String)
{
   a:=0,Sub1:="₁",Sub2:="₂",Sub3:="₃",Sub4:="₄",Sub5:="₅",Sub6:="₆",Sub7:="₇",Sub8:="₈",Sub9:="₉",Sub0:="₀"
   Loop 10
   {
      StringReplace, String, String, % Sub%a%, %a%, All
      a++
   }
Return String
}

SubConvert(String)
{
   a:=0,Sub1:="₁",Sub2:="₂",Sub3:="₃",Sub4:="₄",Sub5:="₅",Sub6:="₆",Sub7:="₇",Sub8:="₈",Sub9:="₉",Sub0:="₀"
   Loop 10
   {
      StringReplace, String, String, %a%, % Sub%a%, All
      a++
   }
Return String
}