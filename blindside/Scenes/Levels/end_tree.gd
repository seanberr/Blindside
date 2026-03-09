extends StaticBody2D


func _on_tree_kill_zone_body_entered(body: Node2D) -> void:
	$Sprite2D.visible = false
	$CollisionShape2D.set_deferred("disabled", true)
