; ===================================================================
; [ Standard Troubleshoot ]

; Project:			HPSM, Beter Flow
; Author:			Kenneth
; ===================================================================

; [ INCLUDES ]
; ============================
#Include globalFunctions.ahk

; [ FUNCTIONS ]
; ============================

; Function that generates the layout for the "Standard Troubleshoot"
standardTroubleshootLayout() {
	global
	Gui, Destroy

	columnWidth:="w205"
	columnGutter:="x30"
	rowGutter:="y30"

	Gui, Show, w500 h670, :D

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
	Gui, Add, Text, Left, Service?
	Gui, Add, Radio, vSERVICE , %TextRadio2_1%
	Gui, Add, Radio, , %TextRadio2_2%
	Gui, Add, Radio, , %TextRadio2_3%
	Gui, Add, Radio, , %TextRadio2_4%
	Gui, Add, Text,  Left, Tagnummer?
	Gui, Add, Edit, %columnWidth% vTAG Left
	Gui, Add, Text, Left, Lokaal / Verdiep?
	Gui, Add, Edit, %columnWidth% vFLOOR Left
	TextRadio1_1 := "Unmanaged"
	TextRadio1_2 := "Basis"
	TextRadio1_3 := "Uitgebreid"
	TextRadio1_4 := "Niet gekend"
	Gui, Add, Text, Left, BHV?
	Gui, Add, Radio, vBHV , %TextRadio1_1%
	Gui, Add, Radio, , %TextRadio1_2%
	Gui, Add, Radio, , %TextRadio1_3%
	Gui, Add, Radio, , %TextRadio1_4%

	;==[ SECOND COLLUMN ]==
	Gui, Add, Text, %rowGutter% x265 Left, Script aanwezig?
	Gui, Add, Checkbox, vSPLICE gSplice, Ja
	Gui, Add, Text, Left , Script ID:
	Gui, Add, Edit, %columnWidth% vSCRIPTID, %scriptID%
	Gui, Add, Text, Left, Script gevolgd?
	Gui, Add, Edit, %columnWidth% vSCRIPTFOLLOW, %scriptFollow%
	Gui, Add, Text, Left, Uitkomst Script?
	Gui, Add, Edit, %columnWidth% r3 vSCRIPTRESULT, %scriptResult%

	GuiControl, disable, SCRIPTID
	GuiControl, disable, SCRIPTFOLLOW
	GuiControl, disable, SCRIPTRESULT

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
	Gui, Add, Text, %columnGutter% y450 w440 Center, Korte omschrijving probleem?
	Gui, Add, Edit, w440 Left vTITLE
	Gui, Add, Text, w440 Center, Uitgebreide omschrijving probleem?
	Gui, Add, Edit, r5 w440 Left vDESC

	Gui, Add, Text, x30 y625 Left, Solved?
	Gui, Add, Checkbox, x80 y625 Left vISSOLVED 
	Gui, Add, Button, x130 y610 w340 h40 vSTANDARDTROUBLESHOOTBUTTON gSTANDARDTROUBLESHOOTBUTTON Center, Press me
	return

	SPLICE:
	Gui, Submit, NoHide
	GuiControl, %    Splice ? "Enable" : "Disable", SCRIPTID
	GuiControl, , SCRIPTID, %    Splice ? "" : ""
	GuiControl, %    Splice ? "Enable" : "Disable", SCRIPTFOLLOW
	GuiControl, , SCRIPTFOLLOW, %    Splice ? "" : ""
	GuiControl, %    Splice ? "Enable" : "Disable", SCRIPTRESULT
	GuiControl, , SCRIPTRESULT, %    Splice ? "" : ""
	return


	STANDARDTROUBLESHOOTBUTTON:
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
		glScriptId := SCRIPTID
		glScriptfollow := SCRIPTFOLLOW
		glScriptResult := SCRIPTRESULT

		;; Dump everthing
		GuiControl,,SCRIPTID,
		GuiControl,,SCRIPTFOLLOW,
		GuiControl,,SCRIPTRESULT,

		if (%SCRIPTAVAILABLE% == 0) 
			glScriptAvailable = Nee
		else 
			glScriptAvailable = Ja

		;; Run checks
		tagCheck()
		priorityCheck()
		serviceCheck()

		;; Run troubleshoot text
		troubleshootSendTop()
		standardTroubleshoot()
		troubleshootSendBottom()

		;; Kill the Gui | Bye bye
		Sleep, 2000
		byeBye()
		gui Destroy
		return
	}	
}

; Function which fills in the text for the "Standard Troubleshoot"
standardTroubleshoot() {
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
}