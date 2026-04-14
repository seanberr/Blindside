extends Node
var memories_collected = {
		1 : false,
		2 : false,
		3 : false,
		4 : false,
		5 : false,
		6 : false,
		7 : false,
		8 : false,
		9 : false,
		10 : false,
		11 : false,
		12 : false,
		13 : false,
		14 : false
}

var extrasUnlocked = false
var splashscreen = false

func set_memory_collected(id : int):
	if id < 1 or id > 14:
		return
	
	memories_collected[id] = true
