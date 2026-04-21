extends Node2D
@export var cutscene : AnimationPlayer
@export var sadie_icon : Sprite2D
@export var alex_icon : Sprite2D
@export var sadie_area : Area2D
var credits_scene = preload("uid://dgypptyt0vwr2")
@export var alex_area : Area2D
@export var cerberus : Node2D
var sadie_at_top : bool = false
var alex_at_top : bool = false
var has_played : bool = false
var sadie : CharacterBody2D
var alex : CharacterBody2D
var is_cam_zoomed : bool = false
var is_screen_blurred : bool = true
var is_blindness_muted : bool = false
var screen_blur : float = 3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sadie_area.body_entered.connect(on_sadie_entered)
	alex_area.body_entered.connect(on_alex_entered)
	sadie_area.body_exited.connect(on_sadie_exited)
	alex_area.body_exited.connect(on_alex_exited)
	
func _process(delta: float) -> void:
	if sadie_at_top and alex_at_top and !has_played:
		has_played = true
		play_cutscene()
	if is_cam_zoomed and sadie:
		sadie.get_node("MainCamera").zoom = lerp(sadie.get_node("MainCamera").zoom, Vector2(0.5,0.5), 0.004)
	if !is_screen_blurred:
		screen_blur = lerp(screen_blur, 0.0, 0.001)
		get_tree().get_first_node_in_group("Level").blur.get_node("BlurRect").material.set_shader_parameter("max_lod", screen_blur)
	if is_blindness_muted:
		get_tree().get_first_node_in_group("Level").get_node("BlindnessModulate").color = lerp(get_tree().get_first_node_in_group("Level").get_node("BlindnessModulate").color, Color(0.5,0.5,0.6,1), 0.003)
	

func on_sadie_entered(body):
	if body.is_in_group("Player") and body.name == "PlayerSadie":
		sadie_at_top = true
		sadie_icon.glow_animator.play("Glow")
	
func on_alex_entered(body):
	if body.is_in_group("Player") and body.name == "PlayerAlex":
		alex_at_top = true
		alex_icon.glow_animator.play("Glow")
		
func on_sadie_exited(body):
	if body.is_in_group("Player") and body.name == "PlayerSadie":
		sadie_at_top = false
		sadie_icon.glow_animator.play("Disable Glow")
		
func on_alex_exited(body):
	if body.is_in_group("Player") and body.name == "PlayerAlex":
		alex_at_top = false
		alex_icon.glow_animator.play("Disable Glow")

func get_players():
	for player in get_tree().get_nodes_in_group("Player"):
		if player.id == 0:
			sadie = player
		elif player.id == 1:
			alex = player
			

func play_cutscene():
	get_players()
	#first do cutscene prep, disable player input
	var players = get_tree().get_nodes_in_group("Player")
	if !players: return
	for player in players:
		player.in_control = false
		player.velocity = Vector2.ZERO
	await get_tree().create_timer(1).timeout
	sadie_icon.disable()
	alex_icon.disable()
	cutscene.play("BoatMoveToGate")
	await get_tree().create_timer(31).timeout
	is_cam_zoomed = true
	is_screen_blurred = false
	is_blindness_muted = true
	await get_tree().create_timer(4).timeout
	cerberus.get_node("CerberusAnimator").play("Appear")
	await get_tree().create_timer(3).timeout
	cerberus.get_node("CerberusAnimator").play("Roar")
	await get_tree().create_timer(6).timeout
	TransitionHandler.transition_to_scene(credits_scene, [Vector2.ZERO, Vector2.ZERO])
	Global.extrasUnlocked = true
