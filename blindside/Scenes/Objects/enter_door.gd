extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_body_entered(body: Node2D) -> void:
	
	# Gets all player
	var players = get_tree().get_nodes_in_group("Player")
	
	# Give each player the ability to push boulders
	for player in players:
		player.able_to_push = true	
