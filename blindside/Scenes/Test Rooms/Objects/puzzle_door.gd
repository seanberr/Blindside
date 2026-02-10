extends StaticBody2D

## Counter for how many pressure plates have been activated
var counter = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
## Function to check pressure plate behaviour
func _pressure_plate_check(value: bool):
	
	## If the pressure plate is activated then:
	if value == true:
		
		## Add one to pressure plate total
		counter += 1
		
		## Check if the lock should be unlocked
		_check_lock()
		
	elif value == false:
		
		counter -= 1	

## Function to open the door
func _open_door():
	
		## Debug code for testing
		$CollisionShape2D.set_deferred("disabled", true)
		$Sprite2D.flip_v = true
	
## Function to check the lock condition
func _check_lock():
	
	## Currently checks if two pressure plates have been activated then:
	if counter == 2:
		
		## Calls the function to open the door
		_open_door()
	

## Whenever a pressure plate is stepped on or off
func _on_pressure_plate_is_activated(value: Variant) -> void:
	
	## Calls the function to check the behaviour of the pressure plate
	_pressure_plate_check(value)
