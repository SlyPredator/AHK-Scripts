; ctrl+capslock to show text case change menu 

#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance force
#NoTrayIcon
#Include %A_ScriptDir%\node_modules
#Include morse.ahk\export.ahk
#include %A_ScriptDir%\Dynamic Expressions.ahk
ExprInit()

GroupAdd All

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
Menu Case, Add, Utilities, :Utilities ; 9

Menu, Case, Icon, &UPPERCASE, D:\Icons\uppercase16.png,, 0
Menu, Case, Icon, &lowercase, D:\Icons\lowercase16.png,, 0
Menu, Case, Icon, &Title Case, D:\Icons\titlecase16.png,, 0
Menu, Case, Icon, &Reverse, D:\Icons\reverse.png,, 0
Menu, Case, Icon, &aLt cApS case, D:\Icons\alternate.png,, 0
Menu, Case, Icon, &Stop. Case., D:\Icons\period.png,, 0
Menu, Case, Icon, Utilities, D:\Icons\utilities.png,, 0
Menu, Utilities, Icon, &Morse, D:\Icons\morse-code.png,, 0
Menu, Utilities, Icon, &Un-Morse, D:\Icons\english.png,, 0
Menu, Utilities, Icon, &Calculate, D:\Icons\calculator.png,, 0
Menu, Utilities, Icon, &Translate, D:\Icons\translate.png,, 0

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
