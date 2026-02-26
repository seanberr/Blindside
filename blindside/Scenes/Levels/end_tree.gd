extends StaticBody2D



func _on_sisyphus_hole_body_entered(body: Node2D) -> void:
	$Sprite2D.visible = false
	$CollisionShape2D.set_deferred("disabled", true)
