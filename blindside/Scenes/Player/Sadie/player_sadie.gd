extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0

# Nearest object variable for the closest object to the player
var NEAR_OBJECT


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		
		# Based on direction the sprite will flip
		if direction > 0:
			$Sprite2D.flip_h = false
			
		elif direction < 0:
			$Sprite2D.flip_h = true
	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	# Handles interacting with objects
	if Input.is_action_just_pressed("ui_accept"):
						
			## Checks if there is an object nearby
			if NEAR_OBJECT != null:
			
			## Checks if the nearest object is interactable
				# Checks for the Interactable group
				if NEAR_OBJECT.is_in_group("Interactable"):
						
					if NEAR_OBJECT.get_node("Interactable").interactable == true:
							
							## Debug code to check functionality
							position = Vector2(0,0)
				
				## Checks for the Memory group
				elif NEAR_OBJECT.is_in_group("Memory"):
					
					## Checks if the object is interactable
					if NEAR_OBJECT.get_node("Interactable").interactable == true:
						
						## Debug code to check functionality
						var tempColour = $Sprite2D.get_modulate() 
						tempColour.r = 1 - tempColour.r
						tempColour.g = 1 - tempColour.g
						tempColour.b = 1 - tempColour.b
						$Sprite2D.modulate = tempColour


				

func _on_interacting_area_area_entered(area: Area2D) -> void:
	
	# When overlapping an area with collision layer 5
	
	# Sets a reference for that object to the nearest object
	NEAR_OBJECT = area
	

func _on_interacting_area_area_exited(area: Area2D) -> void:
			
	# Removes the reference to the closest object
	NEAR_OBJECT = null
