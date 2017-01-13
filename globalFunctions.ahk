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

; [ FUNCTIONS ]
; ============================

; Creates the initial window to select the correct troubleshoot
createInitWindow() {
	global
	Gui, Destroy
	Gui, Show, w500 h500, :D

	Gui, Add, Button, x30 y30 w440 h60 vSTANDAARDTROUBLESHOOT gSTANDAARDTROUBLESHOOT Center, Standaard Troubleshoot
	Gui, Add, Button, w440 h60 vMAILTROUBLESHOOT gMAILTROUBLESHOOT Center, Mail Troubleshoot
	Return
	STANDAARDTROUBLESHOOT:
	{
		Gui, Submit
		standardTroubleshootLayout()
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

; Function to tab back a %count% amount of steps
multTabBack(count) {
	str:=
	loop, %count% {
		str := str . "^+{tab}"
	}

	Send, %str%
}

; Checks whether the script is available
scriptCheck() {
	global
	Gui, Show, w500 h500, :P
	Gui, Add, Text, x10 y10 w480 y10 Left, Script ID?
	Gui, Add, Edit, w480 h19 x10 y30 vSCRIPTID Left
	Gui, Add, Text, x10 y10 w480 y50 Left, Script gevolgd?

	ScriptRadio1_1 := "Ja"
	ScriptRadio1_2 := "Nee"
	Gui, Add, Radio, x10 y70 vSCRIPTFOLLOW , %ScriptRadio1_1%
	Gui, Add, Radio, x70 y70, %ScriptRadio1_2%
	Gui, Add, Text, x10 y10 w480 y90 Left, Uitkomst Script?
	Gui, Add, Edit, r5 w480 h200 x10 y110 vSCRIPTRESULT Left
	Gui, Add, Button, x10 y190 w90 h40 vMYSCRIPTBUTTON gSCRIPTBUTTON Center, Press me
	return

	SCRIPTBUTTON:
	{
		Gui, Submit
		glScriptId := SCRIPTID
		glScriptfollow := SCRIPTFOLLOW
		glScriptResult := SCRIPTRESULT
		
		standardTroubleshoot()
	}

	return
}

; Checks what the service is, and sets its accordingly
serviceCheck() {
	if (glService == "Software") {
		if (glPriority != 5)
			glService = wpaas - software (vobe){tab}{space}
		else
			glService = wpaas - software (vobe)
	} else if (glService == "Windows") {
		if (glPriority != 5)
			glService = wpaas - windows 7 (vobe){tab}{space}
		else
			glService = wpaas - windows 7 (vobe)
	} else if (glService == "Outlook") {
		if (glPriority != 5)
			glService = wpaas - outlook (vobe){tab}{space}
		else
			glService = wpaas - outlook (vobe)
	} else if (glService == "Leeg laten") {
		glService = {tab}+{tab}	
	} else {
		glService = {tab}+{tab}	
	}
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
		Send, ^+{tab}
		clipboard = 
		Send ^a
		Send ^c
		ClipWait, 1
		if (clipboard == "VOBE") {
			Sleep, 1000 
			Break
		}
	}
}