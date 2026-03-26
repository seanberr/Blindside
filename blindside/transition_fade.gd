extends Node2D
@onready var sprite : Sprite2D = $Sprite2D
@onready var animator : AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func transition_in():
	pass
	animator.play("Transitions/Transition In")
	
func transition_out():
	animator = $AnimationPlayer
	animator.play("Transitions/Transition Out")

func init():
	animator = $AnimationPlayer
	sprite = $Sprite2D
	sprite.self_modulate.a = 0
