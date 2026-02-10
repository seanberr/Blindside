extends Area2D

@export var is_locked : bool
@export var scene_to_load : PackedScene
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

@export var pressure_plate_one : Area2D
@export var pressure_plate_two : Area2D


var counter = 0



func _pressure_plate_check(value: bool):
	
	## If the pressure plate is activated then:
	if value == true:
		
		## Add one to pressure plate total
		counter += 1
		
		## Check if the lock should be unlocked
		_check_lock()
		
	elif value == false:
		
		counter -= 1	
		
func _open_door():
	
		## Debug code for testing
		$CollisionShape2D.set_deferred("disabled", true)
		$Sprite2D.flip_v = true
	
## Function to check the lock condition
func _check_lock():
	
	## Currently checks if two pressure plates have been activated then:
	if counter == 2:
		
		## Calls the function to open the door
		unlock()
	
## Whenever a pressure plate is stepped on or off
func _on_pressure_plate_is_activated(value: Variant) -> void:
	## Calls the function to check the behaviour of the pressure plate
	_pressure_plate_check(value)

func _ready() -> void:
	pressure_plate_one.get_node("PressurePlate").is_activated.connect(_on_pressure_plate_is_activated)
	pressure_plate_two.get_node("PressurePlate").is_activated.connect(_on_pressure_plate_is_activated)
	
	if is_locked:
		lock()
	else:
		unlock()

func _physics_process(delta: float) -> void:
	var is_sadie_overlapping : bool = false
	for body in get_overlapping_bodies():
		if body.is_in_group("Player"):
			if body.name == "PlayerSadie":
				is_sadie_overlapping = true
		
	if is_sadie_overlapping:
		if Input.is_action_just_pressed("Player1_Interact"):
			interact()
			
func change_scene():
	if scene_to_load == get_tree().get_current_scene():
		get_tree().change_scene_to_packed(scene_to_load)
	else:
		get_tree().reload_current_scene()
	
func lock():
	is_locked = true
	sprite.play("Locked")
	
func unlock():
	is_locked = false
	sprite.play("Unlocked")
	
func interact():
	if !is_locked:
		change_scene()
