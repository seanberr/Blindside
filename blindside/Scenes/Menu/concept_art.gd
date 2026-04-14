extends Node2D

var art_list : Array = []
var art_name : Array = []
var index = 0
var menu = load("uid://bdwqpu7hq1iqu")

func _ready():
	populate_dictionary()

func populate_dictionary():
	#Loop through children and add to state list dictionary
	for child in $CenterContainer.get_children():
		if child is VBoxContainer:
			art_list.append(child)
	for child in $Titles.get_children():	
		if child is Label:
			art_name.append(child)


func _on_right_pressed() -> void:
	art_list[index].visible = false
	art_name[index].visible = false
	index += 1
	if index >= art_list.size():
		index = 0
	art_list[index].visible = true
	art_name[index].visible = true
	
	


func _on_left_pressed() -> void:
	art_list[index].visible = false
	art_name[index].visible = false
	index -= 1
	if index <= 0:
		index = art_list.size() - 1
	art_list[index].visible = true
	art_name[index].visible = true


func _on_back_pressed() -> void:
	TransitionHandler.transition_to_scene(menu, [Vector2.ZERO, Vector2.ZERO])
