extends Node2D
class_name InteractionComponent

@export var area_of_interaction : Area2D
@export var interaction_input : String
@export var player_id : int #sadie = 1, alex = 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed(interaction_input):
		var interactable_component = search_for_interactable()
		if interactable_component:
			interact_with_object(interactable_component)

func search_for_interactable() -> Interactable:
	var areas = area_of_interaction.get_overlapping_areas()
	#note: will only return first interactable component found, this code isn't meant to handle multiple overlaps
	for area in areas:
		if area.get_parent() is Interactable:
			return area.get_parent()
	return null

func interact_with_object(object : Interactable):
	object.interact(player_id)
