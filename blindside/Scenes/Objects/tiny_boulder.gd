extends RigidBody2D


func _on_area_2d_area_entered(area: Area2D) -> void:
	set_collision_layer_value(7, false)
	set_collision_layer_value(2, true)
