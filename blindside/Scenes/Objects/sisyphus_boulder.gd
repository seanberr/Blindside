extends BaseBoulder

var touchingBoulder = false
var sadie
var alex

func _physics_process(delta: float) -> void:
	
	if touchingBoulder:
		if sadie.state_machine.current_state.name == "Pushing State" and alex.state_machine.current_state.name == "Pushing State":
			if sadie.push_force != 80.0:
				sadie.push_force = 80.0
				alex.push_force = 80.0
		else:
			if sadie.push_force != 0.0:
				sadie.push_force = 0.0
				alex.push_force = 0.0
	
		

func _on_sisyphus_hole_body_entered(body: Node2D) -> void:
	in_place()	
	
	if mass > 100:
		end_scene()

func _on_player_zone_body_entered(body: Node2D) -> void:
	make_unpushable(body.name)


func _on_player_zone_body_exited(body: Node2D) -> void:
	make_pushable(body.name)


func _on_player_count_area_body_entered(body: Node2D) -> void:
	var players = get_tree().get_nodes_in_group("Player")
	if !players: return

	for player in players:
		if player.name == "PlayerSadie":			
			sadie = player
		else:
			alex = player
	touchingBoulder = true	


func _on_player_count_area_body_exited(body: Node2D) -> void:
	touchingBoulder = false
