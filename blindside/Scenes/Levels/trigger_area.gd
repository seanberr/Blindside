extends Area2D
signal player_entered_area
signal player_exited_area

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_entered_area.emit()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_exited_area.emit()
