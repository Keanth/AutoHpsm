; ===================================================================
; [ Hardware Troubleshoot ]

; Project:			HPSM, Beter Flow
; Author:			Kenneth
; ===================================================================

; [ INCLUDES ]
; ============================
#Include globalFunctions.ahk

; [ FUNCTIONS ]
; ============================

; Function that generates the layout for the "Standard Troubleshoot"
hardwareTroubleshootLayout() {
	global
	Gui, Destroy

	windowWidth:="w750"
	windowHeight:="h670"
	columnWidth:="w205"
	columnGutter:="x30"
	rowGutter:="y30"

	Gui, Show, %windowWidth% %windowHeight%, :D

	;==[ FIRST COLLUMN ]==
	Gui, Add, Text, %columnGutter% y30 Left, Achternaam?
	Gui, Add, Edit, %columnWidth% vSURNAME Left
	Gui, Add, Text, Left, Voornaam?
	Gui, Add, Edit, %columnWidth% vNAME Left
	Gui, Add, Text, Left, Telefoonnummer?
	Gui, Add, Edit, %columnWidth% vPHONE Left
	TextRadio2_1 := "Hardware"
	TextRadio2_2 := "iPhone"
	TextRadio2_3 := "iPad"
	TextRadio2_4 := "Android Phone"
	TextRadio2_5 := "Android Tablet"
	TextRadio2_6 := "Leeg laten"
	Gui, Add, Text, Left, Service?
	Gui, Add, Radio, vSERVICE , %TextRadio2_1%
	Gui, Add, Radio, , %TextRadio2_2%
	Gui, Add, Radio, , %TextRadio2_3%
	Gui, Add, Radio, , %TextRadio2_4%
	Gui, Add, Radio, , %TextRadio2_5%
	Gui, Add, Radio, , %TextRadio2_6%
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
	Gui, Add, Checkbox, vSCRIPTAVAILABLE vHARDWARETROUBLESHOOTSPLICE gHARDWARETROUBLESHOOTSPLICE, Ja
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

	;==[ THIRD COLLUMN ]==
	radioHardwareRandapparatuur_1 := "Ja"
	radioHardwareRandapparatuur_2 := "Nee"
	radioHardwareVerderWerken_1 := "Ja"
	radioHardwareVerderWerken_2 := "Nee"
	radioHardwareVerderWerken_3 := "Beperkt vervangtoestel"
	radioHardwareSchade_1 := "Ja"
	radioHardwareSchade_2 := "Nee"

	Gui, Add, Text, %rowGutter% x500 Left, Randapparatuur defect?
	Gui, Add, Text, y45 x500 Left, Foutmelding zonder gevolgen?
	Gui, Add, Radio, vHardwareRandapparatuur , %radioHardwareRandapparatuur_1%
	Gui, Add, Radio, , %radioHardwareRandapparatuur_2%

	Gui, Add, Text, Left, Kan de gebruiker verder werken?
	Gui, Add, Radio, vHardwareVerderWerken , %radioHardwareVerderWerken_1%
	Gui, Add, Radio, , %radioHardwareVerderWerken_2%
	Gui, Add, Radio, , %radioHardwareVerderWerken_3%

	Gui, Add, Text, Left, Zichtbara fysieke schade?
	Gui, Add, Radio, vHardwareSchade , %radioHardwareSchade_1%
	Gui, Add, Radio, , %radioHardwareSchade_2%

	;==[ BOTTOM ROW ]==
	Gui, Add, Text, %columnGutter% y450 w440 Center, Korte omschrijving probleem?
	Gui, Add, Edit, w440 Left vTITLE
	Gui, Add, Text, w440 Center, Uitgebreide omschrijving probleem?
	Gui, Add, Edit, r5 w440 Left vDESC

	Gui, Add, Text, x30 y625 Left, Solved?
	Gui, Add, Checkbox, x80 y625 Left vISSOLVED 
	Gui, Add, Button, x130 y610 w340 h40 vHARDWARETROUBLESHOOTBUTTON gHARDWARETROUBLESHOOTBUTTON Center, Press me
	return

	HARDWARETROUBLESHOOTSPLICE:
	Gui, Submit, NoHide
	GuiControl, %    HARDWARETROUBLESHOOTSPLICE ? "Enable" : "Disable", SCRIPTID
	GuiControl, , SCRIPTID, %    HARDWARETROUBLESHOOTSPLICE ? "" : ""
	GuiControl, %    HARDWARETROUBLESHOOTSPLICE ? "Enable" : "Disable", SCRIPTFOLLOW
	GuiControl, , SCRIPTFOLLOW, %    HARDWARETROUBLESHOOTSPLICE ? "" : ""
	GuiControl, %    HARDWARETROUBLESHOOTSPLICE ? "Enable" : "Disable", SCRIPTRESULT
	GuiControl, , SCRIPTRESULT, %    HARDWARETROUBLESHOOTSPLICE ? "" : ""
	return


	HARDWARETROUBLESHOOTBUTTON:
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

		glHardwareRandapparatuur := radioHardwareRandapparatuur_%glHardwareRandapparatuur%
		glHardwareVerderWerken := radioHardwareVerderWerken_%glHardwareVerderWerken%
		glHardwareSchade := radioHardwareSchade_%glHardwareSchade%

		;; Dump everthing
		GuiControl,,SCRIPTID,
		GuiControl,,SCRIPTFOLLOW,
		GuiControl,,SCRIPTRESULT,

		if (%SCRIPTAVAILABLE% == 0) 
			glScriptAvailable = Nee
		else 
			glScriptAvailable = Ja

		;; Run checks
		runChecks()

		;; Run troubleshoot text
		troubleshootSendTop()
		standardTroubleshoot()
		troubleshootSendBottom()

		;; Kill the Gui | Bye bye | Dump
	    garbageCollector()
	    
		return
	}	
}

; Function which fills in the text for the "Hardware Troubleshoot"
hardwareTroubleshoot() {
	Send, ---KNOWLEDGE--- {enter}
	Send, Randapparatuur defect? Foutmelding zonder gevolgen? %glHardwareRandapparatuur%
	Send, Kan gebruiker verder werken? %glHardwareVerderWerken%
	Send, Zichtbare fysieke schade? %glHardwareSchade%

	Send, Script aanwezig: %glScriptAvailable% {enter}
	Send, Script ID?: %glScriptId% {enter}
	Send, Script gevolgd: %glScriptfollow% {enter}
	Send, Uitkomst script: %glScriptResult% {enter}
}