extends Area2D

@export var is_locked : bool
@export var scene_to_load : PackedScene
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
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
			
## Connects to a specific pressure plate
## When the something moves onto or off the pressure plate it will react
func _on_pressure_plate_is_activated(value: Variant) -> void:
	if value == true:
		unlock()

func change_scene():
	get_tree().change_scene_to_packed(scene_to_load)
	
func lock():
	is_locked = true
	sprite.play("Locked")
	
func unlock():
	is_locked = false
	sprite.play("Unlocked")
	
func interact():
	if !is_locked:
		change_scene()
