extends Node
@export var audio_stream_count : int
var audio_streams : Array[AudioStreamPlayer] = []

var sfx_dict : Dictionary = {
	"Menu_Change" : preload("uid://bbffuofq1w08c"),
	"Menu_Select" : preload("uid://bteultbhdn5f8"),
	"Alex_Jump_Grass" : preload("uid://bfu7y7rprrmi1"),
	"Alex_Jump_Rock" : preload("uid://dddknhr1gbah4"),
	"Sadie_Jump_Grass" : preload("uid://bbdmnowl7jsfy"),
	"Sadie_Jump_Rock" : preload("uid://gwpb0k3m2an3"),
	"Alex_Walk_Grass" : preload("uid://13kdss06wojt"),
	"Alex_Walk_Rock" : preload("uid://bspda2x7xy165"),
	"Sadie_Walk_Grass" : preload("uid://ty6tv7thm0a"),
	"Sadie_Walk_Rock" : preload("uid://gygtfhg3mx6m"),
	"Rock_Moving" : preload("uid://yo4gliru3ki"),
	"Memory_1" : preload("uid://cwvup1xte0muq"),
	"Memory_2" : preload("uid://bsg55ch3hw0cu"),
	"Memory_Bad" : preload("uid://d3asp5k82w023"),
	"Cerberus_Screech" : preload("uid://dan4shksmbaor"),
	"Cerberus_Splash" : preload("uid://pl8k1y6fcylo"),
	"Waterfall" : preload("uid://db2qhi8xxqudm")
	
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(audio_stream_count): #create an array of audio streams (cannot play more sfx at once than this num)
		var new_stream = AudioStreamPlayer.new()
		new_stream.process_mode = Node.PROCESS_MODE_ALWAYS
		new_stream.bus = &"SFX"
		audio_streams.append(new_stream)
		add_child(new_stream)

func play_sound(id: String, volume_db: float, pitch_scale: float): #internal function
	for audio_stream in audio_streams:
		if audio_stream.playing == false:
			if !sfx_dict.has(id):
				return
			audio_stream.stream = sfx_dict[id]
			audio_stream.volume_db = volume_db
			audio_stream.pitch_scale = pitch_scale
			audio_stream.play()
			return
			
func end_all_sounds():
	for stream in audio_streams:
		stream.stop()
		
func end_specific_sound(id: String):
	for stream in audio_streams:
		if stream.stream == sfx_dict[id]:
			stream.stop()

func play_sound_randomizer(possible_ids: Array[String], volume_variance: float, pitch_variance: float, volume_base : float, pitch_base : float): #play sound with some random variance
	var id = possible_ids[randi_range(0,possible_ids.size() - 1)]
	var volume_modifier = randf_range(volume_variance, -volume_variance)
	var pitch_modifier = randf_range(pitch_variance, -pitch_variance)
	
	var randomized_volume = volume_base + volume_modifier
	var randomized_pitch = pitch_base + pitch_modifier
	play_sound(id, randomized_volume, randomized_pitch)
	
func play_sound_default(id: String, volume : float, pitch : float): #play sound default
	play_sound(id, volume, pitch)
