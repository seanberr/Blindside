extends Node
@export var player : CharacterBody2D
@export var sprite : AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(player.name)
	match player.state_machine.current_state.name:
		"Ground Movement State":
			sprite.play("Walk")
			if player.name == "PlayerSadie":	
				sprite.scale = Vector2(0.5, 0.5)
		"Idle State":
			sprite.play("Idle")
			if player.name == "PlayerSadie":	
				sprite.scale = Vector2(0.25, 0.25)
		"Air Movement State":
			sprite.play("Jump")
