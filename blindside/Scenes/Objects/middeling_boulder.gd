extends "res://Scenes/Objects/base_boulder.gd"

func _on_middeling_hole_body_entered(body: Node2D) -> void:
	in_place()


func _on_player_zone_body_entered(body: Node2D) -> void:
	make_unpushable()


func _on_player_zone_body_exited(body: Node2D) -> void:
	make_pushable()
