extends Door

@export var pressure_plate_one : Area2D
@export var pressure_plate_two : Area2D
	
## Function to check the lock condition
func _check_lock():
	## Currently checks if two pressure plates have been activated then:
	if pressure_plate_one.is_activated and pressure_plate_two.is_activated:
		## Calls the function to open the door
		unlock()

## Whenever a pressure plate is stepped on or off
func _on_pressure_plate_is_pressed() -> void:
	## Calls the function to check the behaviour of the pressure plate
	_check_lock()

func _ready() -> void:
	scene_to_load = load("res://Scenes/Levels/platforming_room_one.tscn")
	pressure_plate_one.is_pressed.connect(_on_pressure_plate_is_pressed)
	pressure_plate_two.is_pressed.connect(_on_pressure_plate_is_pressed)
	
	if is_locked:
		lock()
	else:
		unlock()
			
