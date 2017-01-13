; ===================================================================
; [ AutoHpsm ]

; Project:				AutoHpscm | HPSM, Beter Flow
; Target Application	HPSM
; Version:				0.1
; Last change:			2016/01/10 [Changelog.txt]
; Upcomung change:		[Futurelog.txt]
; Author:				Kenneth


; [ Table of contents ]

; 1. 					META
; 2. 					INCLUDES
; 3. 					MAIN

; [ Required files ]

; 1.					standardTroubleshoot.ahk
; 2.					globalFunctions.ahk
; ===================================================================


; [ META ]
; ============================
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force ; Makes sure only one instane of this script is running at a specific time

; [ INCLUDES ]
; ============================
#Include standardTroubleshoot.ahk
#Include mailTroubleshoot.ahk
#Include globalFunctions.ahk

; [ MAIN ]
; ============================
^m::
	createInitWindow()
Return