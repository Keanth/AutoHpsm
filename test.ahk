^k::
	; clipboard = 
	while clipboard != "VOBE" {
		Send, ^+{tab}
		clipboard = 
		Send ^a
		Send ^c
	}
Return

FindVobe() {
	while clipboard != "VOBE" {
		Send, ^+{tab}
		clipboard = 
		Send ^a
		Send ^c
	}	
}


^l::
	multTabControl(10)
Return

multTabControl(count) {
	str:=
	loop, %count% {
		str := str . "^{tab}"
	}

	Send, %str%
}