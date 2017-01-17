; ===================================================================
; [ VPN Troubleshoot ]

; Project:			HPSM, Beter Flow
; Author:			Kenneth
; ===================================================================

; [ INCLUDES ]
; ============================
#Include globalFunctions.ahk

; [ FUNCTIONS ]
; ============================

; Function that generates the layout for the "Standard Troubleshoot"
vpnTroubleshootLayout() {
	global
	Gui, Destroy

	columnWidth:="w205"
	columnGutter:="x30"
	rowGutter:="y30"

	Gui, Show, w750 h670, :D

	;==[ FIRST COLLUMN ]==
	Gui, Add, Text, %columnGutter% %rowGutter% Left, Achternaam?
	Gui, Add, Edit, %columnWidth% vSURNAME Left
	Gui, Add, Text, Left, Voornaam?
	Gui, Add, Edit, %columnWidth% vNAME Left
	Gui, Add, Text, Left, Telefoonnummer?
	Gui, Add, Edit, %columnWidth% vPHONE Left
	TextRadio2_1 := "Teleworking Software"
	TextRadio2_2 := "Teleworking Hardware"
	TextRadio2_3 := "Teleworking Connection"
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
	Gui, Add, Checkbox, vSCRIPTAVAILABLE vVPNTROUBLESHOOTSPLICE gVPNTROUBLESHOOTSPLICE, Ja
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
	radioInternetWerkt_1 := "Ja"
	radioInternetWerkt_2 := "Nee"
	radioAndereToestellen_1 := "Ja"
	radioAndereToestellen_2 := "Nee"
	radioConnectieMethode_1 := "Draadloos"
	radioConnectieMethode_2 := "Kabel"
	radioEid_1 := "EID"
	radioEid_2 := "Federaal Token"
	radioIeReset_1 := "Ja"
	radioIeReset_2 := "Nee"
	radioAntiVirus_1 := "Ja"
	radioAntiVirus_2 := "Nee"
	radioVpnReset_1 := "Ja"
	radioVpnReset_2 := "Nee"
	radioGebruikerVerder_1 := "Ja"
	radioGebruikerVerder_2 := "Nee"
	radioProbleemGemeld_1 := "Ja"
	radioProbleemGemeld_2 := "Nee"

	Gui, Add, Text, %rowGutter% x500 Left , IP Adres:
	Gui, Add, Edit, %columnWidth% vIPADRES Left

	Gui, Add, Text, Left, Internet Werkt?
	Gui, Add, Radio, vInternetWerkt , %radioInternetWerkt_1%
	Gui, Add, Radio, , %radioInternetWerkt_2%

	Gui, Add, Text, Left, Andere toestellen met internetverbinding?
	Gui, Add, Radio, vAndereToestellen , %radioAndereToestellen_1%
	Gui, Add, Radio, , %radioAndereToestellen_2%

	Gui, Add, Text, Left, Connectiemethode?
	Gui, Add, Radio, vConnectieMethode , %radioConnectieMethode_1%
	Gui, Add, Radio, , %radioConnectieMethode_2%

	Gui, Add, Text, Left, EID of Federaal Token?
	Gui, Add, Radio, vEid , %radioEid_1%
	Gui, Add, Radio, , %radioEid_2%

	Gui, Add, Text, Left, Internet Explorer reset?
	Gui, Add, Radio, vIeReset , %radioIeReset_1%
	Gui, Add, Radio, , %radioIeReset_2%

	Gui, Add, Text, Left, Anti-Virus goed verbonden?
	Gui, Add, Radio, vAntiVirus , %radioAntiVirus_1%
	Gui, Add, Radio, , %radioAntiVirus_2%

	Gui, Add, Text, Left, VPN opnieuw geinstalleerd?
	Gui, Add, Radio, vVpnReset , %radioVpnReset_1%
	Gui, Add, Radio, , %radioVpnReset_2%

	Gui, Add, Text, Left, Kan gebruiker verder werken?
	Gui, Add, Radio, vGebruikerVerder , %radioGebruikerVerder_1%
	Gui, Add, Radio, , %radioGebruikerVerder_2%

	Gui, Add, Text, Left, Probleem al eerder gemeld?
	Gui, Add, Radio, vProbleemGemeld , %radioProbleemGemeld_1%
	Gui, Add, Radio, , %radioProbleemGemeld_2%

	;==[ BOTTOM ROW ]==
	Gui, Add, Text, %columnGutter% y450 w440 Center, Korte omschrijving probleem?
	Gui, Add, Edit, w440 Left vTITLE
	Gui, Add, Text, w440 Center, Uitgebreide omschrijving probleem?
	Gui, Add, Edit, r5 w440 Left vDESC

	Gui, Add, Text, x30 y625 Left, Solved?
	Gui, Add, Checkbox, x80 y625 Left vISSOLVED 
	Gui, Add, Button, x130 y610 w340 h40 vVPNTROUBLESHOOTBUTTON gVPNTROUBLESHOOTBUTTON Center, Press me
	return

	VPNTROUBLESHOOTSPLICE:
		Gui, Submit, NoHide
		GuiControl, %    VPNTROUBLESHOOTSPLICE ? "Enable" : "Disable", SCRIPTID
		GuiControl, , SCRIPTID, %    VPNTROUBLESHOOTSPLICE ? "" : ""
		GuiControl, %    VPNTROUBLESHOOTSPLICE ? "Enable" : "Disable", SCRIPTFOLLOW
		GuiControl, , SCRIPTFOLLOW, %    VPNTROUBLESHOOTSPLICE ? "" : ""
		GuiControl, %    VPNTROUBLESHOOTSPLICE ? "Enable" : "Disable", SCRIPTRESULT
		GuiControl, , SCRIPTRESULT, %    VPNTROUBLESHOOTSPLICE ? "" : ""
	return

	VPNTROUBLESHOOTBUTTON:
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

		glIpAdres := IPADRES
		glInternetWerkt := radioInternetWerkt_%InternetWerkt%
		glAndereToestellen := radioAndereToestellen_%AndereToestellen%
		glConnectieMethode := radioConnectieMethode_%ConnectieMethode%
		glEid := radioEid_%Eid%
		glIeReset := radioIeReset_%IeReset%
		glAntiVirus := radioAntiVirus_%AntiVirus%
		glVpnReset := radioVpnReset_%VpnReset%
		glGebruikerVerder := radioGebruikerVerder_%GebruikerVerder%
		glProbleemGemeld := radioProbleemGemeld_%ProbleemGemeld%

		if (%VPNTROUBLESHOOTSPLICE% == 0) 
			glScriptAvailable = Nee
		else 
			glScriptAvailable = Ja

		;; Run checks
		tagCheck()
		priorityCheck()
		serviceCheck()

		;; Run troubleshoot text
		troubleshootSendTop()
		vpnTroubleshoot()
		troubleshootSendBottom()

		;; Kill the Gui | Bye bye | Dump
	    garbageCollector()

		return
	}	
}

; Function which fills in the text for the "VPN Troubleshoot"
vpnTroubleshoot() {
	Send, ---KNOWLEDGE--- {enter}
	Send, Script aanwezig: %glScriptAvailable% {enter}
	Send, Script ID?: %glScriptId% {enter}
	Send, Script gevolgd: %glScriptfollow% {enter}
	Send, Uitkomst script: %glScriptResult% {enter}

	Send, Internet: %glInternetWerkt% {enter}
	Send, Andere toestellen hebben internet: %glAndereToestellen% {enter}
	Send, Connectiemethode: %glConnectieMethode% {enter}
	Send, EID of Federaal token: %glEid% {enter}
	Send, Internet Explorer reset: %glIeReset% {enter}
	Send, Anti-Virus goed verbonden: %glAntiVirus% {enter}
	Send, VPN opnieuw geinstalleerd: %glVpnReset% {enter}
	Send, IP Adres: %glIpAdres% {enter}
	Send, Kan gebruiker verder werken: %glGebruikerVerder% {enter}
	Send, Probleem al eerder gemeld: %glProbleemGemeld% {enter}
}