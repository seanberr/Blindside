extends Node
var memories_collected = {
		0 : false,
		1 : false,
		2 : false,
		3 : false,
		4 : false,
		5 : false,
		6 : false,
		7 : false,
}

func set_memory_collected(id : int):
	memories_collected[id] = true
