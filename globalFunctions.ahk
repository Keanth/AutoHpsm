; ===================================================================
; [ Global Functions]

; Project:			HPSM, Beter Flow
; Author:			Kenneth
; ===================================================================

; [ GLOBAL VARIABLES ]
; ============================
global glSurName:=""
global glName:=""
global glPhone:=""
global glMail:=""
global glFloor:=""
global glService:=""
global glTag:=1
global glTitleTag:=""
global glBhv:=""
global glPriority:=""
global glScriptAvailable:=""
global glScriptId:=""
global glScriptfollow:=""
global glScriptResult:=""
global glTitle:=""
global glDescription:=""
global glIsSolved:=""

global glReport:="" ;; Implement later

;; VPN specific
global glIpAdres:=""
global glInternetWerkt:=""
global glAndereToestellen:=""
global glConnectieMethode:=""
global glEid:=""
global glIeReset:=""
global glAntiVirus:=""
global glVpnReset:=""
global glGebruikerVerder:=""
global glProbleemGemeld:=""

;; Hardware specific
global glHardwareRandapparatuur:=""
global glHardwareVerderWerken:=""
global glHardwareSchade:=""

; [ FUNCTIONS ]
; ============================

; Creates the initial window to select the correct troubleshoot
createInitWindow() {
	global
	Gui, Destroy
	Gui, Show, w500 h500, :D

	Gui, Add, Button, x30 y30 w440 h60 vSTANDAARDTROUBLESHOOT gSTANDAARDTROUBLESHOOT Center, Standaard Troubleshoot
	Gui, Add, Button, w440 h60 vVPNTROUBLESHOOT gVPNTROUBLESHOOT Center, VPN Troubleshoot
	Gui, Add, Button, w440 h60 vHARDWARETROUBLESHOOT gHARDWARETROUBLESHOOT Center, Hardware Troubleshoot
	Gui, Add, Button, w440 h60 vENQUIRYTROUBLESHOOT gENQUIRYTROUBLESHOOT Center, Enquiry
	Gui, Add, Button, w440 h60 vMAILTROUBLESHOOT gMAILTROUBLESHOOT Center, Mail Troubleshoot

	Return
	STANDAARDTROUBLESHOOT:
	{
		Gui, Submit
		standardTroubleshootLayout()
		return
	}
	VPNTROUBLESHOOT:
	{
		Gui, Submit
		vpnTroubleshootLayout()
		return
	}
	HARDWARETROUBLESHOOT:
	{
		Gui, Submit
		hardwareTroubleshootLayout()
		return
	}
	ENQUIRYTROUBLESHOOT:
	{
		Gui, Submit
		enquiryTroubleshootLayout()
		return
	}
	MAILTROUBLESHOOT:
	{
		Gui, Submit
		mailTroubleshootLayout()
		return
	}
	
	return
}

; Function to tab forward a %count% amount of steps
multTab(count) {
	str:=
	loop, %count% {
		str := str . "{tab}"
	}

	Send, %str%
}

; Function to tab forward a %count% amount of steps with CONTROL hold down
multTabControl(count) {
	Sleep, 1000
	str:=
	loop, %count% {
		str := str . "^{tab}"
	}

	Send, %str%
}

; Function to tab back a %count% amount of steps
multTabBack(count) {
	str:=
	loop, %count% {
		str := str . "^+{tab}"
	}

	Send, %str%
}


; Function that runs alls the checks at once
runChecks() {
	;; Run checks
	tagCheck()
	priorityCheck()
	serviceCheck()
}

; Checks what the service is, and sets its accordingly
serviceCheck() {
	if (glService == ""){ 
		glService = {tab}+{tab}	
		Return
	}

	if (glService == "Software")
		glService = wpaas - software (vobe)
	else if (glService == "Windows")
		glService = wpaas - windows 7 (vobe)
	else if (glService == "Outlook")
		glService = wpaas - outlook (vobe)
	Else if (glService == "Skype")
		glService = wpaas - lync (vobe)
	else if (glService == "Teleworking Software")
		glService = wpaas - teleworking software (vobe)
	else if (glService == "Teleworking Hardware")
		glService = wpaas - teleworking hardware (vobe)
	else if (glService == "Teleworking Connection")
		glService = wpaas - teleworking connection (vobe)
	else if (glService == "Hardware")
		glService = wpaas - hardware (vobe)
	else if (glService == "iPhone")
		glService = wpaas - ios phone (vobe)
	else if (glService == "iPad")
		glService = wpaas - ios tablet (vobe)
	else if (glService == "Android Phone")
		glService = wpaas - android phone (vobe)
	else if (glService == "Android Tablet")
		glService = wpaas - android tablet (vobe)

	if (glService == "Leeg laten")
		glService = {tab}+{tab}	
	else if (glPriority != 5)
		glService = %glService%{tab}{space}	
}

; Checks if the tag is correct
tagCheck() {
	glTagLength := StrLen(glTag)
	StringLen, glTagLength, glTag

	if (glTag == "" || glTagLength != 7) {
		glTag := ""
		glTitleTag := ""
	} else {
		glTitleTag = %glTag% -
		glTag = %glTag% ;{tab}{space}
	}
}

; Checks what the current priority is set to, and than sets it to the correspending number
priorityCheck() {
	if (glPriority == "Priority 1") {
		glPriority = 1
	} else if (glPriority == "Priority 2") {
		glPriority = 2
	} else if (glPriority == "Priority 3") {
		glPriority = 3
	} else if (glPriority == "Priority 4") {
		glPriority = 4
	} else if (glPriority == "Priority 5"){
		glPriority = 5
	}
}

; A function which finds the location of VOBE
FindVobe() {
	Loop, 20 {
		clipboard = 
		Send ^a
		Send ^c
		ClipWait, 1
		if (clipboard == "VOBE") {
			Sleep, 250 
			Break
		} else {
			Send, ^+{tab}
		}
	}
}

FindVobeForward() {
	Loop, 20 {
		clipboard = 
		Send ^a
		Send ^c
		ClipWait, 1
		if (clipboard == "VOBE") {
			Sleep, 250 
			Break
		} else {
			Send, ^{tab}
		}
	}
}

troubleshootSendTop() {
	; Make sure HPSM is active
	IfWinExist, HP Service Manager 
	    WinActivate ; use the window found above
	else 
	    ExitApp

	Send, {tab}{tab}{Down}{Enter}
	multTab(2)
	Send, VOBE{tab}EXTERNE.GEBRUIKER@VOBE{tab}{space}
	FindVobeForward()
	
	if (glPriority == 5) {
		multTab(20)
		Send, {space}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{enter}
		multTab(19)
		Send, {Delete}
		multTabBack(7) 	
	}
	else {
		multTab(13)
	}

	Sleep, 1000 
	Send, %glService%

	FindVobe()
	multTab(16)
	Sleep, 1500 

	Send, %glTag%
	FindVobe() 
	if (glPriority == 5) {
		multTab(22) 
	}
	else {
		multTab(21) 
	}
	Send, %glSurName%, %glName% - %glTitleTag% %glTitle%
	multTab(3)
	Send, ^a {delete}

	Send, --VALIDATIE---- {enter}
	Send, Gebruikersgegevens gevalideerd: Ja {enter}
	Send, telefoon: %glPhone% {enter}
	Send, Lokaal/Verdiep: %glFloor% {enter}
	Send, Bereikbaarheid: 16:00 {enter}
	Send, BHV HPSM: %glBhv% {enter}
	Send, Priomatrix gevolgd: Ja {enter}
	Send, Hot Transfer? Nee {enter}
	Send, {enter}
}

troubleshootSendBottom() {
	Send, {enter}
	Send, ---OWNERID--- {enter}
	Send, 50050113 {enter}
	Send, {enter}
	Send, ---OMSCHRIJVING PROBLEEM--- {enter}
	Send, %glDescription%
	Sleep, 1000

	Send, ^{tab}{tab}
	Send, incident{tab}{tab}application{tab}{tab}performance degradation{tab}{tab}

	if (glPriority == 3 || glPriority == 4 || glPriority == 5) {
		Send, {tab}%glPriority%{tab}
	} else {
		Send, %glPriority%{tab}%glPriority%{tab}
	}

	if (glIsSolved == 1)
	{
		multTab(4)
		Send, Solved
		multTab(6)
		Send, %glDescription%
		Send, {enter}{enter}
		Send, GAS
	} 
	else 
	{
		multTab(11)
	}

	if (glPriority == 5)
		multTabBack(44)
	else
		multTabBack(43)
	

	Sleep, 1000

	Send, ^a
	Send, %glSurName%, %glName% 
	Send, {tab}{space}
}

garbageCollector() {
	Sleep, 2000
    ; Dump everthing
	GuiControl,,SCRIPTID, ""
	GuiControl,,SCRIPTFOLLOW, ""
	GuiControl,,SCRIPTRESULT, ""
	glScriptAvailable = Nee

	; byeBye()
	
	gui Destroy
	Reload
}

byeBye() {
	MsgBox, , Done and Done, Script is done running.`nYour life got 30`% easier.`n`nYou're welcome., 5
}