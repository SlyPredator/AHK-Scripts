#NoTrayIcon
#SingleInstance force

-----------------------------------------------------------------------------------------------
/*

	OCCUPIED HOTKEYS : 
		
		F2 - Autohide Taskbar Toggle
		@@ - Email
		@! - Email
        	Alt + b - Wallpaper Slideshow Toggle
		Alt + g - Select Text and Search in Bing
        	Alt + n - Night Light Toggle
		Alt + s - Spotify Web 
		Alt + t - Google Translate Web
        	Alt + v - Volume Mixer
        	R-Alt + Space - Blank Text Box
		Double Space(Slow) - Period + space
        	Mouse Up/Down/Click/Double Click/Triple Click - Volume Controls (ONLY ON TASKBAR!)
*/
-----------------------------------------------------------------------------------------------

; TaskBar Hide

VarSetCapacity(APPBARDATA, A_PtrSize=4 ? 36:48)

~F2::
NumPut(DllCall("Shell32\SHAppBarMessage", "UInt", 4 ; ABM_GETSTATE
, "Ptr", &APPBARDATA
, "Int")
? 2:1, APPBARDATA, A_PtrSize=4 ? 32:40) ; 2 - ABS_ALWAYSONTOP, 1 - ABS_AUTOHIDE
, DllCall("Shell32\SHAppBarMessage", "UInt", 10 ; ABM_SETSTATE
, "Ptr", &APPBARDATA)
KeyWait, % A_ThisHotkey
Return
-----------------------------------------------------------------------------------------------

; Email IDs

:*:@@::navneethmahadevan@gmail.com 
:*:@!::navneethmahadevan@hotmail.com
-----------------------------------------------------------------------------------------------

; Volume Mixer

!v::
run ms-settings:sound
sleep, 1000
send {Tab 10}
send {Space}
Return
-----------------------------------------------------------------------------------------------

; Night Light Toggle

!n::
run ms-settings:nightlight
sleep, 700
send {Tab 3}
send {Space}
if WinExist("Settings")
    WinClose 
Return
-----------------------------------------------------------------------------------------------

; Google Translate in Edgium

!t::
Run, "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" https://translate.google.com/, , Max
Return
-----------------------------------------------------------------------------------------------

; Change Picture to Slideshow in Background

!b::
run ms-settings:personalization-background
sleep, 1000
send {Tab 2}
send {Space}
send {Down 2}
send {Space}
Return
-----------------------------------------------------------------------------------------------

; Spotify Web

!s::
Run, "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" https://open.spotify.com/, , Max
Return
-----------------------------------------------------------------------------------------------

; Hotstrings 

::il::I'll
::theyre::they're
::youll::you'll
::youre::you're
::youve::you've
::cant::can't
::youd::you'd
::theyll::they'll
::wont::won't 
::wouldve::would've
::wouldnt::wouldn't
::whats::what's 
::whatver::whatever
::whos::who's 
::theyve::they've
::isnt::isn't
::dont::don't 
::smwhere::somewhere
::uve::you've
::u::you
::ull::you'll
::ure::you're
::ur::your
::weve::we've
::im::I'm 
::i::I
::havent::haven't
::shes::she's
::hes::he's 
::didnt::didn't
::diff::different
::doesnt::doesn't
::itll::it'll
::arent::aren't
::defi::definitely
::ive::I've
::shouldve::should've
::shouldnt::shouldn't
::mightve::might've
::mightnt::mightn't 
::thatll::that'll
::smthg::something
::wasnt::wasn't
::hasnt::hasn't
::hadnt::hadn't
::couldnt::couldn't
::thats::that's
::fav::favourite
::hows::how is
::theres::there's 
::aint::ain't 
::maam::ma'am
::ryt::right
::rytt::rightt
::ryttt::righttt
::mustve::must've
::thatd::that'd
::howd::how'd 
::werent::weren't 
::urself::yourself
::nthg::nothing
::couldve::could've
::yest::yesterday
::whyre::why are
::whatd::what did
::whyd::why did
::srsly::seriously
::heres::here's
::yall::y'all
::urs::yours
::shant::shan't
::wheres::where's
::rvcli::java -jar revanced-cli-all.jar -b revanced-patches.jar -m integrations.apk -a youtube.apk -o out.apk --experimental
::asciipy::py main.py --file images.jpeg --cols 120
-----------------------------------------------------------------------------------------------

; Subscripts

:?*:~1::{U+2081} ; 1
:?*:~2::{U+2082} ; 2
:?*:~3::{U+2083} ; 3
:?*:~4::{U+2084} ; 4
:?*:~5::{U+2085} ; 5
:?*:~6::{U+2086} ; 6
:?*:~7::{U+2087} ; 7
:?*:~8::{U+2088} ; 8
:?*:~9::{U+2089} ; 9
:?*:~0::{U+2080} ; 0
:?*:~+::{U+208A} ; +
:?*:~-::{U+208B} ; -
:?*:~=::{U+208C} ; =
:?*:~(::{U+208D} ; (
:?*:~)::{U+208E} ; )
:?*:~a::{U+2090} ; a
:?*:~e::{U+2091} ; e
:?*:~o::{U+2092} ; o
:?*:~x::{U+2093} ; x
:?*:~?::{U+2090} ; schwa
:?*:~h::{U+2095} ; h
:?*:~k::{U+2096} ; k
:?*:~l::{U+2097} ; l
:?*:~m::{U+2098} ; m
:?*:~n::{U+2099} ; n
:?*:~p::{U+209A} ; p
:?*:~s::{U+209B} ; s
:?*:~t::{U+209C} ; t

; Superscripts

:?*:^1::{U+00B9} ; 1
:?*:^2::{U+00B2} ; 2
:?*:^3::{U+00B3} ; 3
:?*:^4::{U+2074} ; 4
:?*:^5::{U+2075} ; 5
:?*:^6::{U+2076} ; 6
:?*:^7::{U+2077} ; 7
:?*:^8::{U+2078} ; 8
:?*:^9::{U+2079} ; 9
:?*:^0::{U+2070} ; 0
:?*:^i::{U+2071} ; i
:?*:^n::{U+207F} ; n
:?*:^x::{U+02E3} ; x
:?*:^+::{U+207A} ; +
:?*:^-::{U+207B} ; -
:?*:^=::{U+207C} ; =
:?*:^(::{U+207D} ; (
:?*:^)::{U+207E} ; )
-----------------------------------------------------------------------------------------------

; Insert period after double space

~$space::
    {
        keywait, space
        keywait, space, d t.14
        if (!errorlevel) && (a_thishotkey = "~$" . a_priorkey)
        {
            sendinput, {backspace 2}.%a_space%
        }
    }
return
-----------------------------------------------------------------------------------------------

; alt+g : open highlighted text in browser and do google search / visit site (if it's url)

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force
#NoTrayIcon
SetTitleMatchMode 2


!g::
MyClip := ClipboardAll
Clipboard = ; empty the clipboard
Send, ^c
ClipWait, 2
if ErrorLevel  ; ClipWait timed out.
{
    return
}
if RegExMatch(Clipboard, "^[^ ]*\.[^ ]*$")
{
    Run "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" %Clipboard%
}
else  
{
    ; Modify some characters that screw up the URL
    ; RFC 3986 section 2.2 Reserved Characters (January 2005):  !*'();:@&=+$,/?#[]
    StringReplace, Clipboard, Clipboard, `r`n, %A_Space%, All
    StringReplace, Clipboard, Clipboard, #, `%23, All
    StringReplace, Clipboard, Clipboard, &, `%26, All
    StringReplace, Clipboard, Clipboard, +, `%2b, All
    StringReplace, Clipboard, Clipboard, ", `%22, All
    Run % "https://www.bing.com/search?hl=en&q=" . clipboard ; uriEncode(clipboard)
}
Clipboard := MyClip
return

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

; Pastes text from a variable while preserving the clipboard.
PutText(MyText)
{
   SavedClip := ClipboardAll 
   Clipboard =              ; For better compatability
   Sleep 20                 ; with Clipboard History
   Clipboard := MyText
   Send ^v
   Sleep 100
   Clipboard := SavedClip
   Return
}
Return 
-----------------------------------------------------------------------------------------------

; Blank entry area

RAlt & Space::
InputBox, UserInput, Text Box, , , 300, 100
Return
-----------------------------------------------------------------------------------------------

; Volume/Media controls with scroll actions on taskbar 

#If MouseIsOver("ahk_class Shell_TrayWnd")

WheelUp::
Send {Volume_Up}
return

WheelDown::
Send {Volume_Down}
return

MButton::
Send {Volume_Mute}
return

~LButton::
if quickclicks > 0
{
    quickclicks += 1
    Return
}

quickclicks = 1
SetTimer, TheKey, 600
Return

TheKey:
SetTimer, TheKey, off

if quickclicks = 3 ; The key was pressed thrice   
   {
   SendInput, {Media_Prev}
   }
if quickclicks = 2 ; The key was pressed twice   
	{
	SendInput, {Media_Next}
	}
quickclicks = 0
Return

MouseIsOver(WinTitle) {
    MouseGetPos,,, Win
    return WinExist(WinTitle . " ahk_id " . Win)
}
Return
-----------------------------------------------------------------------------------------------
