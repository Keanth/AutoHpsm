; [ FUNCTIONS ]
; ============================

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
		glService = wpaas - software (vobe){tab}{space}
	} else if (glService == "Windows") {
		glService = wpaas - windows 7 (vobe){tab}{space}
	} else if (glService == "Outlook") {
		glService = wpaas - outlook (vobe){tab}{space}
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
		glTag = %glTag%{tab}{space}
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