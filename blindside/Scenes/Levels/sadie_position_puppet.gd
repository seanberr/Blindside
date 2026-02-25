extends Node
class_name PlayerAnimationController
var sadie : CharacterBody2D
var alex : CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sadie = get_sadie()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func get_sadie() -> CharacterBody2D:
	var players = get_tree().get_nodes_in_group("Player")
	for player in players:
		if player.name == "PlayerSadie":
			return player
	return null
	
func get_alex() -> CharacterBody2D:
	var players = get_tree().get_nodes_in_group("Player")
	for player in players:
		if player.name == "PlayerAlex":
			return player
	return null
	
func sadie_move_to_edge():
	sadie = get_sadie()
	if sadie.position.x <= 10:
		sadie.position.x += 2
		
func alex_move_to_edge():
	alex = get_alex()
	if alex.position.x >= 530:
		alex.position.x -= 2

func sadie_jump():
	apply_impulse(sadie, Vector2(175, -690))
	
func alex_jump():
	apply_impulse(alex, Vector2(-180, -590))

func apply_impulse(player: CharacterBody2D, impulse: Vector2):
	player.velocity += impulse
