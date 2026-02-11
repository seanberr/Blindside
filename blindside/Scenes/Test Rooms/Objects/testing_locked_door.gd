extends Area2D

@export var is_locked : bool
@export var scene_to_load : PackedScene
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

@export var pressure_plate_one : Area2D
@export var pressure_plate_two : Area2D

var counter = 0
		
func _open_door():
	
		## Debug code for testing
		$CollisionShape2D.set_deferred("disabled", true)
		$Sprite2D.flip_v = true
	
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
	pressure_plate_one.is_pressed.connect(_on_pressure_plate_is_pressed)
	pressure_plate_two.is_pressed.connect(_on_pressure_plate_is_pressed)
	
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
	TransitionHandler.transition_to_scene(scene_to_load)
	
func lock():
	is_locked = true
	sprite.play("Locked")
	
func unlock():
	is_locked = false
	sprite.play("Unlocked")
	
func interact():
	if !is_locked:
		change_scene()
