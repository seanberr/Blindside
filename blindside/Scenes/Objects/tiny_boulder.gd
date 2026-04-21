extends BaseBoulder

func _on_tiny_hole_body_entered(body: Node2D) -> void:
	# When the boulder is in the hole, call the in_place function
	in_place()

func _on_fail_zone_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	# If the player is in the fail zone, call the reset function
	reset()

func _on_player_zone_body_entered(body: Node2D) -> void:
	# if the player is in front of the boulder, make them unable to push it
	make_unpushable(body.name)

func _on_player_zone_body_exited(body: Node2D) -> void:
	# If the player is not in front of the boulder anymore, restore their ability to push it
	make_pushable(body.name)
