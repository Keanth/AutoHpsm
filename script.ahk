; ===================================================================
; [ AutoHpsm ]

; Project:				AutoHpscm | HPSM, Beter Flow
; Target Application	HPSM
; Version:				0.1
; Last change:			2016/01/10 [Changelog.txt]
; Upcomung change:		[Futurelog.txt]
; Author:				Kenneth


; [Table of contents]

; 1. 					META
; 2. 					GLOBAL VARIABLES
; 3. 					MAIN
; 4. 					FUNCTIONS
; 4.1 					CHECKS
; ===================================================================


; [ META ]
; ============================
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

; [ GLOBAL VARIABLES ]
; ============================
global glSurName:=""
global glName:=""
global glPhone:=""
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

; [ MAIN ]
; ============================
^m::
	Gui, Destroy
	Gui, Show, w500 h500, :D

	Gui, Add, Button, x30 y30 w440 h60 vSTANDAARDTROUBLESHOOT gSTANDAARDTROUBLESHOOT Center, Standaard Troubleshoot
	Return
	STANDAARDTROUBLESHOOT:
	{
		Gui, Submit
		standardTroubleshootLayout()
	}
Return


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
	
	; add PRIO5 check
	; =============================
	multTab(25)
	Send, {space}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{Down}{enter}
	multTab(19)
	Send, {Delete}
	multTabBack(9) ;Service field
	%glService%
	Send, {enter}
	; add PRIO5 check
	; =============================

	multTab(17)
	Send, %glService%
	multTab(3)
	Send, %glTag%
	multTab(5)
	Send, %glSurName%, %glName% - %glTitleTag% %glTitle%
	multTab(3)
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
	Send, incident{tab}{tab}application{tab}{tab}performance degradation{tab}{tab}{tab}%glPriority%{tab}
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

; ==[ CHECKS ]==
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

priorityCheck() {
	if (glPriority == "Priority 1") {
		glPriority = 1
	} else if (glPriority == "Priority 2") {
		glPriority = 2
	} else if (glPriority == "Priority 3") {
		glPriority = 3
	} else if (glPriority == "Priority 4") {
		glPriority = 4
	}
	; } else {
	; 	glPriority = 5
	; }
}

isPrioFive(){

}