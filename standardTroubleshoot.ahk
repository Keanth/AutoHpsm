; ===================================================================
; [ Standard Troubleshoot ]

; Project:			HPSM, Beter Flow
; Author:			Kenneth
; ===================================================================



; [ FUNCTIONS ]
; ============================

; Function that generates the layout for the "Standard Troubleshoot"
standardTroubleshootLayout() {
	global
	Gui, Destroy

	columnWidth:="w205"
	columnGutter:="x30"
	rowGutter:="y30"

	Gui, Show, w500 h600, :D

	;==[ FIRST COLLUMN ]==
	Gui, Add, Text, %columnGutter% y30 Left, Achternaam?
	Gui, Add, Edit, %columnWidth% vSURNAME Left
	Gui, Add, Text, Left, Voornaam?
	Gui, Add, Edit, %columnWidth% vNAME Left
	Gui, Add, Text, Left, Telefoonnummer?
	Gui, Add, Edit, %columnWidth% vPHONE Left
	TextRadio2_1 := "Software"
	TextRadio2_2 := "Windows"
	TextRadio2_3 := "Outlook"
	TextRadio2_4 := "Leeg laten"
	Gui, Add, Radio, vSERVICE , %TextRadio2_1%
	Gui, Add, Radio, , %TextRadio2_2%
	Gui, Add, Radio, , %TextRadio2_3%
	Gui, Add, Radio, , %TextRadio2_4%
	Gui, Add, Text,  Left, Tagnummer?
	Gui, Add, Edit, %columnWidth% vTAG Left
	Gui, Add, Text, Left, Lokaal / Verdiep?
	Gui, Add, Edit, %columnWidth% vFLOOR Left
	
	;==[ SECOND COLLUMN ]==
	TextRadio1_1 := "Unmanaged"
	TextRadio1_2 := "Basis"
	TextRadio1_3 := "Uitgebreid"
	TextRadio1_4 := "Niet gekend"
	Gui, Add, Text, %rowGutter% x265 Left, BHV?
	Gui, Add, Radio, vBHV , %TextRadio1_1%
	Gui, Add, Radio, , %TextRadio1_2%
	Gui, Add, Radio, , %TextRadio1_3%
	Gui, Add, Radio, , %TextRadio1_4%
	Gui, Add, Text, Left, Script aanwezig?
	Gui, Add, Checkbox, vSCRIPTAVAILABLE, Ja
	TextRadio3_1 := "Priority 1"
	TextRadio3_2 := "Priority 2"
	TextRadio3_3 := "Priority 3"
	TextRadio3_4 := "Priority 4"
	TextRadio3_5 := "Priority 5"
	Gui, Add, Text, Left, Priority?
	Gui, Add, Radio, vPRIORITYLEVEL , %TextRadio3_1%
	Gui, Add, Radio, , %TextRadio3_2%
	Gui, Add, Radio, , %TextRadio3_3%
	Gui, Add, Radio, , %TextRadio3_4%
	Gui, Add, Radio, , %TextRadio3_5%

	;==[ BOTTOM ROW ]==
	Gui, Add, Text, %columnGutter% y350 w440 Center, Korte omschrijving probleem?
	Gui, Add, Edit, w440 Left vTITLE
	Gui, Add, Text, w440 Center, Uitgebreide omschrijving probleem?
	Gui, Add, Edit, r5 w440 Left vDESC

	Gui, Add, Text, x30 y565 Left, Solved?
	Gui, Add, Checkbox, x80 y565 Left vISSOLVED 
	Gui, Add, Button, x130 y550 w340 h40 vMYBUTTON gBUTTON Center, Press me
	return

	BUTTON:
	{
		Gui, Submit ;; Pull in all the variables to their global representative
		glSurName := SURNAME
		glName := NAME
		glPhone := PHONE
		glFloor := FLOOR
		glService := TextRadio2_%SERVICE%
		glTag := TAG
		glBhv := TextRadio1_%BHV%
		glTitle := TITLE
		glDescription := DESC
		glIsSolved := ISSOLVED
		glPriority := PRIORITYLEVEL
		; glPriority := 5

		;; Run checks
		serviceCheck()
		tagCheck()
		priorityCheck()


		if (%SCRIPTAVAILABLE% == 0) { 
			glScriptAvailable = Nee
			standardTroubleshoot()
		}
		else { 
			Gui Destroy
			scriptCheck()
		}

		return
	
	}	
}

; Function which fills in the text for the "Standard Troubleshoot"
standardTroubleshoot() {
	Send, {Down}{Enter}
	multTab(2)
	Send, VOBE{tab}ONBEKENDE.GEBRUIKER@VOBE{tab}{space}
	
	; ==[ PRIO 5 check ]==
	if (glPriority == 5) {
		multTab(24)
		Send, {space}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{enter}
		multTab(19)
		Send, {Delete}
		multTabBack(7) ; Ends in "Service field"
		Send, %glService%
		Send, {enter} ; Ends in "Service Provider"
		multTab(3)
	}
	; ==[ /PRIO 5 check ]==
	; ==[ PRIO 1-4 check ]==
	else {
		multTab(17)
		Send, %glService%
		multTab(3)
	}
	; ==[ /PRIO 1-4 check ]==

	Send, %glTag%
	multTab(5)
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
	Send, ---KNOWLEDGE--- {enter}
	Send, Script aanwezig: %glScriptAvailable% {enter}
	Send, Script ID?: %glScriptId% {enter}
	Send, Script gevolgd: %glScriptfollow% {enter}
	Send, Uitkomst script: %glScriptResult% {enter}
	Send, ---OWNERID--- {enter}
	Send, 50050113 {enter}
	Send, {enter}
	Send, ---OMSCHRIJVING PROBLEEM--- {enter}
	Send, %glDescription%

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
		Send, {enter}
		Send, GAS
		multTabBack(43)
	} 
	else 
	{
		multTabBack(33)
	}
	Send, ^a
	Send, %glSurName%, %glName% 
	Send, {tab}{space}
}