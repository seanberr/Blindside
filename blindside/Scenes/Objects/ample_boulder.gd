extends RigidBody2D


func _on_ample_hole_body_entered(body: Node2D) -> void:
	
	# Disabled the interaction with player
	set_collision_layer_value(7, false)
	set_collision_mask_value(7, false)
	mass = 10000
	
	## Enable typical static collision with player
	set_collision_layer_value(2, true)
