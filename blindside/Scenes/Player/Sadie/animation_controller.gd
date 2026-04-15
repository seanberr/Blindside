extends Node
@export var player : CharacterBody2D
@export var sprite : AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if player.in_control:
		match player.state_machine.current_state.name:
			"Ground Movement State":
				sprite.play("Walk")
				if player.name == "PlayerSadie":	
					sprite.scale = Vector2(0.5, 0.5)
			"Idle State":
				sprite.play("Idle")
				if player.name == "PlayerSadie":	
					sprite.scale = Vector2(0.25, 0.25)
			"Preparing to Jump State":
				sprite.play("AlmostJump")
			"Air Movement State":
				if player.name == "PlayerSadie":	
					sprite.scale = Vector2(0.25, 0.25)
				sprite.play("Jump")
			"Pushing State":
				if player.name == "PlayerSadie":
					if Input.is_action_pressed("Player1_Left") or Input.is_action_pressed("Player1_Right"):
						sprite.play("Walk")
						sprite.scale = Vector2(0.5, 0.5)
					else:
						sprite.play("Idle")
						sprite.scale = Vector2(0.25, 0.25)
				else:
					if Input.is_action_pressed("Player2_Left") or Input.is_action_pressed("Player2_Right"):
						sprite.play("Walk")
						
					else:
						sprite.play("Idle")
	else:				
		sprite.play("Idle")
		if player.name == "PlayerSadie":	
			sprite.scale = Vector2(0.25, 0.25)
