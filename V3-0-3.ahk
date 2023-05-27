 ; Init Tags
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force
SetWinDelay, -1


; ===============================================================================================================================
; CONFIG
global guiWidth := 1000
global guiHeight := 500
global sidebarWidth := 250
global maxSteps := 6
global stepsPadding := 85
global sleepTime := 1200

   ; steps
  global st0 := "Welcome"
  global st1 := "Getting Ready"
  global st2 := "Checking System"
  global st3 := "Copying Files"
  global st4 := "Validating Install"
  global st5 := "Cleaning Up"
  global st6 := "Finish"
; ===============================================================================================================================


OnMessage(0x0201, "WM_LBUTTONDOWN")
WS_POPUP = 0x80000000
WS_CHILD = 0x40000000
WS_CHILD2 = 0x20000000
WM_MOUSEMOVE = 0x200

global currentStep := -1
global progAmt := 0

Gui, 1: +LastFound -Caption -Border +hWndhGui1 +Owner
Gui, 1: Color, 0x808080
WinSet, TransColor, 0x808080, % "ahk_id " hGui1
Gui, 1: Add, Picture, w%guiWidth% h%guiHeight% x0 y0  AltSubmit BackgroundTrans, Resources\Solids\Grey.png
Gui, 1:Add, Picture, w60 h60 x12 y60  AltSubmit BackgroundTrans, Resources\InstallerAssets\LogoSmall1X.png
Gui, 1: Font, s20, Segoe UI
Gui, 1: Add, Text, w200 x70 y70 vinstallerText AltSubmit BackgroundTrans c0x880B53, Installer

Gui, 1: Font, s8, Segoe MDL2 Assets

yBullets := 70 + stepsPadding
bulletCount := 0
While(bulletCount <= maxSteps) {
  yPos := yBullets + 26 * bulletCount
  bulletLabel := "bullet" + bulletCount
  Gui, 1: Add, Text, w200 h28 x25 y%yPos% v%bulletLabel% AltSubmit BackgroundTrans c0x808080 +Redraw, 
  bulletCount++
}

Gui, 1:Font, s12, Segoe UI

ySteps := yBullets - 7
stepCount := 0
While(stepCount <= maxSteps) {
  yPos2 := ySteps + 26 * stepCount
  stepLabel := "step" + stepCount
  Gui, 1: Add, Text, w200 h28 x40 y%yPos2% v%stepLabel% AltSubmit BackgroundTrans c0x808080 +Redraw, %stepLabel%
  stepCount++
}

GuiControl, Text, step0, %st0%
GuiControl, Text, step1, %st1%
GuiControl, Text, step2, %st2%
GuiControl, Text, step3, %st3%
GuiControl, Text, step4, %st4%
GuiControl, Text, step5, %st5%
GuiControl, Text, step6, %st6%

Parent_ID := WinExist()

Gui, 2:margin,1,1
Gui, 2: +LastFound -Caption -Border +hWndhGui2 +%WS_CHILD% -%WS_POPUP%
Gui, 2: Color, 000001
WinSet, TransColor, 000001, % "ahk_id " hGui2
Gui, 1: Font, s10 c0x909090, Segoe UI Semibold
Gui, 1: Add, Text, w700 h500 x25 y450 vversionText BackgroundTrans, Version 3.0.1 (ARC1)
Gui, 1: Font, s10 c0x880B53, Segoe UI Semibold
Gui, 1: Add, Text, w700 h500 x25 y450 vdevCreditText BackgroundTrans c0x880B53,`nDeveloped by @yuvraj
Gui, 2: +LastFound

Child_ID := WinExist()
DllCall("SetParent", "uint",  Child_ID, "uint", Parent_ID)

global mainPanelWidth := GuiWidth - SidebarWidth

Gui, 3:margin,1,1
Gui, 3: -Caption -Border +hWndhGui3 +%WS_CHILD% -%WS_POPUP%
Gui, 3: Color, F0F0F0
WinSet, Transparent, 255, % "ahk_id " hGui3
Gui, 3: Add, Picture, w1 h1 x960 y0 vcloseBackG, Resources\Solids\Red.bmp
 GuiControl, Move, closeBackG, w-2
Gui, 3: Font, s10, Segoe MDL2 Assets
clsButtonX := guiWidth - 26
Gui, 3: Add, Text, w14 h14 x%clsButtonX% y9 cBlack gCloseApp vcloseButton BackgroundTrans, 
Gui, 3: Add, Picture, w400 h300 x300 y50 vlogoNeu, Resources\InstallerAssets\LogoNeu1X.png
Gui, 3: Font, s18, Segoe UI Light
Gui, 3: Add, Text, x435 y355 c0x303030, VE Tools 2021
Gui, 3: Font, s12, Segoe UI
Gui, 3:Add, Text, x460 y400 h30 gStep0 c0x880B53, Begin Setup
Gui, 3: +LastFound
Child_ID := WinExist()
DllCall("SetParent", "uint",  Child_ID, "uint", Parent_ID)

Gui, 1: Font, s10, Segoe UI Semibold


FrameShadow(hGui1)
Gui, 1: Show, w%guiWidth% h%guiHeight%
EnableBlur(hGui1)

Gui, 2: Show, x0 y0 w%sidebarWidth% h%guiHeight%

Gui, 3: Show, x0 y0 w%guiWidth% h%guiHeight%

OnMessage(0x200,"WM_MOUSEMOVE")

return







Step0:

currentStep := 0

formatStep(currentStep)

GuiControl, Hide, logoNeu
Gui, 3:margin,1,1
Gui, 3: -Caption -Border +hWndhGui3 +%WS_CHILD% -%WS_POPUP%
Gui, 3: Color, F0F0F0
WinSet, Transparent, 255, % "ahk_id " hGui3
GuiControl, Move, closeBackG, w-2 x710
clsButtonX := mainPanelWidth - 26
GuiControl, Move, closeButton, x%clsButtonX%
Gui, 3: Font, s32, Segoe UI Light
Gui, 3: Add, Text, w1000 h80 x25 y56 c0x000000 vmainTitle, %st0%
Gui, 3: Font, s12, Segoe UI
Gui, 3: Add, Text, w700 h500 x25 y%ySteps% c0x000000 vmainBody, This setup tool will automate the process of copying the Up Learn Video Editing Tools to their necessary locations.`n`nYou may close the window to cancel at any time.
Gui, 3: Font, s18, Segoe UI
Gui, 3:Add, Text, x25 y440 w100 h30 gStep1 c0x880B53 vmainButtonCont, Continue
Gui, 3: +LastFound
Child_ID := WinExist()
DllCall("SetParent", "uint",  Child_ID, "uint", Parent_ID)

Gui, 3: Show, x%sidebarWidth% y0 w%mainPanelWidth% h%guiHeight%
return




Step1:
currentStep := 1

formatStep(currentStep)

GuiControl, Text, mainTitle, %st1%
GuiControl, Text, mainBody, Gathing Files...
GuiControl, Hide, mainButtonCont
Gui, 3:Add, Progress, x25 y465 w700 h10 vmainProg Range0-1000 -Smooth, %progAmt%

Global totalULVET := 0
GuiControl, Text, mainBody, Gathing Files...`nAdobe Premiere Pro project template
if FileExist("Resources\ULVET\Template.prproj") {
  totalULVET ++
  }
InsProg(200)
Sleep %sleepTime%

GuiControl, Text, mainBody, Gathing Files...`nAdobe Media Encoder export settings preset file
if FileExist("Resources\ULVET\Up Learn VE Export Settings Preset.epr") {
  totalULVET ++
  }
InsProg(400)
Sleep %sleepTime%


GuiControl, Text, mainBody, Gathing Files...`nAdobe Premiere Pro keyboard shortcut preset file
if FileExist("Resources\ULVET\Up Learn VE Keyboard Shortcut Preset.kys") {
  totalULVET ++
  }
InsProg(600)
Sleep %sleepTime%


GuiControl, Text, mainBody, Gathing Files...`nAdobe Premiere Pro sequence preset file
if FileExist("Resources\ULVET\Up Learn VE Sequence Preset.sqpreset") {
  totalULVET ++
  }
InsProg(800)
Sleep %sleepTime%

If (totalULVET = 4){
  GuiControl, Text, mainBody, Done! Initialising install.
InsProg(1000)
Sleep %sleepTime%
goto Step2
}else{
  GuiControl, Text, mainBody, Could not find Up Learn VE Tools in installer files.`nMake sure you extracted the installer files correctly and try again.
  InsProg(0)
  return
}
return





Step2:
currentStep := 2
formatStep(currentStep)

GuiControl, Text, mainTitle, %st2%

GuiControl, Text, mainBody, Checking system architecture...
InsProg(167)
Sleep %sleepTime%

If (A_Is64bitOS){
  GuiControl, Text, mainBody, 64-bit Windows installed.
  InsProg(334)
Sleep %sleepTime%
}else{
  GuiControl, Text, mainBody, Could not verify system architecture.`nMake sure you have a 64-bit Windows installed and your system is 64-bit capable.
}

GuiControl, Text, mainBody, 64-bit Windows installed.`nGetting Adobe Premiere Pro version
GetPremiereProVersion()
InsProg(500)
Sleep %sleepTime%

If (latestVersion!="") {
  GuiControl, Text, mainBody, 64-bit Windows installed`nAdobe Premiere Pro %latestPr% detected!
  InsProg(667)
Sleep %sleepTime%
}else{
  GuiControl, Text, mainBody, 64-bit Windows installed.`nCould not find Adobe Premiere Pro installed on your system.`nMake sure you have a supported version installed before running the VE Tools installer.
}

GuiControl, Text, mainBody, 64-bit Windows installed.`nAdobe Premiere Pro %latestPr% detected!`nGetting PowerPoint version
global latestPpt := GetPowerPointVersion()
InsProg(833)
Sleep %sleepTime%

If (latestPpt!="") {
  GuiControl, Text, mainBody, 64-bit Windows installed`nAdobe Premiere Pro %latestPr% detected!`nMicrosoft PowerPoint %latestPpt% detected!
  InsProg(1000)
Sleep %sleepTime%
goto Step3
}else{
  GuiControl, Text, mainBody, 64-bit Windows installed.`nAdobe Premiere Pro %latestPr% detected!`nCould not find Microsoft PowerPoint installed on your system.`nMake sure you have a supported version installed before running the VE Tools installer.
}

return





Step3:
currentStep := 3
formatStep(currentStep)

GuiControl, Text, mainTitle, %st3%

GuiControl, Text, mainBody, Copying Premiere Pro template
FileCreateDir, %APPDATA%\Up Learn\VE Tools\ULVEX
FileCreateDir, %APPDATA%\Up Learn\VE Tools\ULVEX\Resources

InsProg(200)

return





CloseApp:
If (currentStep<1){
ExitApp
}else{
  MsgBox, 4,, Would you like to exit steup?
    IfMsgBox Yes
      ExitApp
}












 ;Lib

WM_MOUSEMOVE(wParam, lParam) {

MouseGetPos,,,, ctrl

if (ctrl == "Static2") {
  GuiControl, Move, closeBackG, w40 h32
  GuiControl +c0xFFFFFF, closeButton
  }else{
 GuiControl, Move, closeBackG, w-2
  GuiControl +c0x000000, closeButton
  }


EnableBlur(hWnd)
{
  ;Function by qwerty12 and jNizM (found on https://autohotkey.com/boards/viewtopic.php?t=18823)

  ;WindowCompositionAttribute
  WCA_ACCENT_POLICY := 19
 
  ;AccentState
  ACCENT_DISABLED := 0,
  ACCENT_ENABLE_GRADIENT := 1,
  ACCENT_ENABLE_TRANSPARENTGRADIENT := 2,
  ACCENT_ENABLE_BLURBEHIND := 3,
  ACCENT_INVALID_STATE := 4

  accentStructSize := VarSetCapacity(AccentPolicy, 4*4, 0)
  NumPut(ACCENT_ENABLE_BLURBEHIND, AccentPolicy, 0, "UInt")
 
  padding := A_PtrSize == 8 ? 4 : 0
  VarSetCapacity(WindowCompositionAttributeData, 4 + padding + A_PtrSize + 4 + padding)
  NumPut(WCA_ACCENT_POLICY, WindowCompositionAttributeData, 0, "UInt")
  NumPut(&AccentPolicy, WindowCompositionAttributeData, 4 + padding, "Ptr")
  NumPut(accentStructSize, WindowCompositionAttributeData, 4 + padding + A_PtrSize, "UInt")
 
  DllCall("SetWindowCompositionAttribute", "Ptr", hWnd, "Ptr", &WindowCompositionAttributeData)
}



FrameShadow(HGui) {
	DllCall("dwmapi\DwmIsCompositionEnabled","IntP",_ISENABLED) ; Get if DWM Manager is Enabled
	if !_ISENABLED ; if DWM is not enabled, Make Basic Shadow
		DllCall("SetClassLong","UInt",HGui,"Int",-26,"Int",DllCall("GetClassLong","UInt",HGui,"Int",-26)|0x20000)
	else {
		VarSetCapacity(_MARGINS,16)
		NumPut(1,&_MARGINS,0,"UInt")
		NumPut(1,&_MARGINS,4,"UInt")
		NumPut(1,&_MARGINS,8,"UInt")
		NumPut(1,&_MARGINS,12,"UInt")
		DllCall("dwmapi\DwmSetWindowAttribute", "Ptr", HGui, "UInt", 2, "Int*", 2, "UInt", 4)
		DllCall("dwmapi\DwmExtendFrameIntoClientArea", "Ptr", HGui, "Ptr", &_MARGINS)
	}
}

WM_LBUTTONDOWN(wParam, lParam, msg, hwnd) {
	static init := OnMessage(0x0201, "WM_LBUTTONDOWN")
	PostMessage, 0xA1, 2,,, A
}

InsProg(amt){
  GuiControl,, mainProg, %amt%
; By Yuvraj Sethia
}

formatStep(stepNumber){

  local prevStep := stepNumber - 1
  local nextStep := stepNumber + 1
  
  Gui, 1: Font, s8 c0x404040, Segoe MDL2 Assets
  GuiControl 1:Font, bullet%prevStep%
  
  Gui, 1: Font, s8 c0x880B53, Segoe MDL2 Assets
  GuiControl 1:Font, bullet%stepNumber%

  Gui, 1: Font, s12 c0x404040, Segoe UI
  GuiControl 1:Font, step%prevStep%
  

  Gui, 1: Font, s12 c0x880B53, Segoe UI
  GuiControl 1:Font, step%stepNumber%
  
  local currentStepProcessing := nextStep
  While( currentStepProcessing <= maxSteps ) {
    Gui, 1: Font, s8 c0x808080, Segoe MDL2 Assets
    GuiControl 1:Font, bullet%currentStepProcessing%
    Gui, 1: Font, s12 c0x808080, Segoe UI
    GuiControl 1:Font, step%currentStepProcessing%
    currentStepProcessing++
  }
  
;By Yuvraj Sethia
}

GetPremiereProVersion(){
	if InStr(FileExist("C:\Program Files\Adobe\Adobe Premiere Pro 2017"), "D") {
      global latestVersion:="11.0"
      global latestPr:="2017"
    }
	if InStr(FileExist("C:\Program Files\Adobe\Adobe Premiere Pro 2018"), "D"){
      global latestVersion:="12.0"
      global latestPr:="2018"
    }
	if InStr(FileExist("C:\Program Files\Adobe\Adobe Premiere Pro 2019"), "D"){
      global latestVersion:="13.0"
      global latestPr:="2019"
    }
	if InStr(FileExist("C:\Program Files\Adobe\Adobe Premiere Pro 2020"), "D"){
      global latestVersion:="14.0"
      global latestPr:="2020"
    }
    if InStr(FileExist("C:\Program Files\Adobe\Adobe Premiere Pro 2021"), "D"){
      global latestVersion:="15.0"
      global latestPr:="2021"
    }
;By Yuvraj Sethia
}

GetPowerPointVersion(){
	if InStr(FileExist("C:\Program Files\Microsoft Office\Office12\"), "D") {
      latest:="2007"
      return, 
    }
    if InStr(FileExist("C:\Program Files\Microsoft Office 14\ClientX64\Root\Office14\"), "D") {
      latest:="2010 Click-To-Run"
    }
    if InStr(FileExist("C:\Program Files\Microsoft Office\Office14\"), "D") {
      latest:="2010"
    }
    if InStr(FileExist("C:\Program Files\Microsoft Office 15\ClientX64\Root\Office15\"), "D") {
      latest:="2013 Click-To-Run"
    }
    if InStr(FileExist("C:\Program Files\Microsoft Office\Office15\"), "D") {
      latest:="2013"
    }
    if InStr(FileExist("C:\Program Files (x86)\Microsoft Office 16\ClientX86\Root\Office16\"), "D") {
      latest:="2016/365 Click-To-Run"
    }
    if InStr(FileExist("C:\Program Files\Microsoft Office\Office16\"), "D") {
      latest:="2016/365"
    }
	return, latest
    }
;By Yuvraj Sethia
}
