extends Node2D
class_name Platform

@export var standing_area : Area2D
@export var underneath_area : Area2D
@export var collision_sadie : CollisionShape2D
@export var collision_alex : CollisionShape2D
@export var label_sadie : Label
@export var label_alex : Label

var player_standing : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label_sadie.text = "collision sadie"
	label_alex.text = "collision alex"
	collision_sadie.disabled = false
	collision_alex.disabled = false
	
	standing_area.body_entered.connect(body_enter_standing)
	standing_area.body_exited.connect(body_exit_standing)
	underneath_area.body_entered.connect(body_enter_underneath)
	underneath_area.body_exited.connect(body_exit_underneath)

func body_enter_underneath(body: Node):
	if body.is_in_group("Player"):
		if body.id == 0:
			label_sadie.text = "NO collision sadie"
			collision_sadie.set_deferred("disabled", true)
		elif body.id == 1:
			label_alex.text = "NO collision alex"
			collision_alex.set_deferred("disabled", true)


func body_exit_underneath(body: Node):
	if body.is_in_group("Player"):
		if body.id == 0:
			label_sadie.text = "collision sadie"
			collision_sadie.set_deferred("disabled", false)
		elif body.id == 1:
			label_alex.text = "collision alex"
			collision_alex.set_deferred("disabled", false)

func body_enter_standing(body: Node2D):
	if body.is_in_group("Player"):
		player_standing = true
	
func body_exit_standing(body: Node2D):
	if body.is_in_group("Player"):
		player_standing = false
	# ensure there are no other players standing
	var bodies = standing_area.get_overlapping_bodies()
	for node in bodies:
		if node.is_in_group("Player"):
			player_standing = true
