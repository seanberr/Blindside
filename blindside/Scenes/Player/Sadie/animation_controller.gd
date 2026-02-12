extends Node
@export var player : CharacterBody2D
@export var sprite : AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.is_on_floor() and Input.is_action_pressed("Player1_Left") or Input.is_action_pressed("Player1_Right"):
		sprite.play("Walk")
	else:
		sprite.play("Idle")
