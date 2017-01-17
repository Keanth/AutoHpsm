; ===================================================================
; [ Enquiry Troubleshoot ]

; Project:			HPSM, Beter Flow
; Author:			Kenneth
; ===================================================================

; [ INCLUDES ]
; ============================
#Include globalFunctions.ahk

; [ FUNCTIONS ]
; ============================

; Function that generates the layout for the "Standard Troubleshoot"
enquiryTroubleshootLayout() {
	global
	Gui, Destroy

	windowWidth:="w500"
	windowHeight:="h470"
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
	Gui, Add, Text,  Left, Tagnummer?
	Gui, Add, Edit, %columnWidth% vTAG Left

	;==[ BOTTOM ROW ]==
	Gui, Add, Text, %columnGutter% y250 w440 Center, Korte omschrijving probleem?
	Gui, Add, Edit, w440 Left vTITLE
	Gui, Add, Text, w440 Center, Uitgebreide omschrijving probleem?
	Gui, Add, Edit, r5 w440 Left vDESC

	Gui, Add, Text, x30 y425 Left, Solved?
	Gui, Add, Checkbox, x80 y425 Left vISSOLVED 
	Gui, Add, Button, x130 y410 w340 h40 vENQUIRYTROUBLESHOOTBUTTON gENQUIRYTROUBLESHOOTBUTTON Center, Press me
	return

	ENQUIRYTROUBLESHOOTBUTTON:
	{
		Gui, Submit ;; Pull in all the variables to their global representative
		glSurName := SURNAME
		glName := NAME
		glPhone := PHONE
		glTag := TAG
		glTitle := TITLE
		glDescription := DESC
		glIsSolved := ISSOLVED

		glPriority := "Priority 5"

		;; Run checks
		runChecks()

		;; Run troubleshoot text
		troubleshootSendTop()
		troubleshootSendBottom()

		;; Kill the Gui | Bye bye | Dump
	    garbageCollector()
	    
		return
	}	
}

; Function which fills in the text for the "Enquiry Troubleshoot"
enquiryTroubleshoot() {
}