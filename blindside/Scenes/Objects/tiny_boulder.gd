extends "res://Scenes/Objects/base_boulder.gd"


func _on_tiny_hole_body_entered(body: Node2D) -> void:
		
	in_place()


func _on_fail_zone_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	reset()

func _on_player_zone_body_entered(body: Node2D) -> void:
	make_unpushable()

func _on_player_zone_body_exited(body: Node2D) -> void:
	make_pushable()
