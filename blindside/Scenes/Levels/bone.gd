extends Node2D
@export var area : Area2D
@export var animator : AnimationPlayer
var is_cracked : bool = false
var ready_to_break : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if area:
		area.body_entered.connect(on_area_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_area_entered(body):
	if body.is_in_group("Player") and body is CharacterBody2D:
		if !is_cracked:
			enter_cracked_state()
		elif ready_to_break:
			enter_broken_state()
		
		
func enter_cracked_state():
	if is_cracked:
		return
	animator.play("Crack")
	is_cracked = true
	
func enter_broken_state():
	queue_free()
