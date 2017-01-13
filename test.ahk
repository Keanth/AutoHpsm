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