extends ColorRect
var player1 : CharacterBody2D
var player2 : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_players()
	
func get_players():
	var players = get_tree().get_nodes_in_group("Player")
	if players:
		player1 = players[0]
		player2 = players[1]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !player1 or !player2:
		get_players()
	var viewport := get_viewport()
	var canvas_transform := viewport.get_canvas_transform()
	var p1_screen = canvas_transform * player1.global_position
	var p2_screen = canvas_transform * player2.global_position
	var viewport_size = viewport.get_visible_rect().size
	material.set_shader_parameter("player1_uv", p1_screen / viewport_size)
	material.set_shader_parameter("player2_uv", p2_screen / viewport_size)
