extends Node2D
@export var invisible_walls : Array[CollisionShape2D]
@export var bone : Node2D
@export var cutscene : AnimationPlayer
@export var sadie_icon : Sprite2D
@export var alex_icon : Sprite2D
@export var sadie_area : Area2D
@export var alex_area : Area2D
var sadie_at_top : bool = false
var alex_at_top : bool = false
var has_played : bool = false


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

func play_cutscene():
	#first do cutscene prep, disable player input
	var players = get_tree().get_nodes_in_group("Player")
	if !players: return
	for player in players:
		player.in_control = false
		
	#disable invisible walls
	for wall in invisible_walls:
		wall.disabled = true
		
	#prep bone to break
	bone.ready_to_break = true
		
	await get_tree().create_timer(1.5).timeout
	cutscene.play("Cutscenes/Move To Edge")
	await get_tree().create_timer(1.5).timeout
	cutscene.pause()
	await get_tree().create_timer(1).timeout
	cutscene.play("Cutscenes/Jump")
	await get_tree().create_timer(2.2).timeout
	for player in players:
		player.in_control = true
	
