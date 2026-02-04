extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = -600.0


func _physics_process(delta: float) -> void:
	
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("MoveLeft", "MoveRight")
	if direction:
		velocity.x = direction * SPEED	
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	direction = Input.get_axis("MoveUp", "MoveDown")
	if direction:
		velocity.y = direction * SPEED	
		
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	move_and_slide()

func _on_alex_circle_area_entered(area: Area2D) -> void:
	# When Alex and Sadie are close double the size of the light
	# Uses collision layer 3
	
	$PointLight2D.scale = Vector2 ($PointLight2D.scale.x * 2, $PointLight2D.scale.y * 2)
	

func _on_alex_circle_area_exited(area: Area2D) -> void:
	# When Alex and Sadie are far away half the size of the light
	# Uses collision layer 3
	
	$PointLight2D.scale = Vector2 ($PointLight2D.scale.x / 2, $PointLight2D.scale.y / 2)
	


func _on_interacting_circle_area_entered(area: Area2D) -> void:
	# When Alex is near an interactable object
	# Uses collision layer 4
	
	if area.is_in_group("Interactable"):
		area.get_node("Interactable").interactable  = true
		
	# Debug code to check functionality
	$PointLight2D.color = Color(0.71, 0.224, 0.796, 1.0)
	

func _on_interacting_circle_area_exited(area: Area2D) -> void:
	# When Alex leaves an interactable object
	# Uses collision layer 4
	
	if area.is_in_group("Interactable"):
		area.get_node("Interactable").interactable  = false
			
	# Debug code to check functionality
	$PointLight2D.color = Color(1.0, 1.0, 1.0, 1.0)
	
