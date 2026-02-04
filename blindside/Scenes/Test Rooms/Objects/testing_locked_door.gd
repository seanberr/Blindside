extends StaticBody2D

## Connects to a specific pressure plate
## When the something moves onto or off the pressure plate it will react
func _on_pressure_plate_is_activated(value: Variant) -> void:
	
	if value == true:
		
		## Debug code for testing
		$CollisionShape2D.set_deferred("disabled", value)
		$Sprite2D.flip_v = value
		
	elif value == false:
		
		## Debug code for testing
		$CollisionShape2D.set_deferred("disabled", value)
		$Sprite2D.flip_v = value
		
	
