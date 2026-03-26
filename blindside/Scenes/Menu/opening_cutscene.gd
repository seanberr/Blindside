extends Control
var progression_counter : int = 0
@export var intro_label: Label
@export var game_scene : PackedScene
var intro_text : Array[String] = [
"Sadie approaches death’s door. After a grave car crash, 
her soul was dragged into The Interstice – a malleable realm
between life and death. Her ever-faithful guide dog, Alex, 
has followed her even here. Obscured memories from long ago 
rendered her helpless against dogs until Alex appeared. 
Together, they journey into oblivion.",
"Manifestations of their shared past fester within this
personalised limbo. Mementos of a hazy past and sublime present.
The ghost of Sadie’s fear – a scar left by her childhood dog named 
Gretel – threatens to ensnare her in its insidious embrace.",
]



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Player1_Interact"):
		progression_counter += 1
		
		if progression_counter > intro_text.size() - 1:
			TransitionHandler.transition_to_scene(game_scene, [Vector2(-540.0,258.0), Vector2(-455.0,258.0)])
		else:
			intro_label.advance_text(intro_text[progression_counter])
		
	
