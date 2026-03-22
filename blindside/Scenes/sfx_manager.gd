extends Node
@export var audio_stream_count : int
var audio_streams : Array[AudioStreamPlayer] = []

var sfx_dict : Dictionary = {
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
			
func play_sound_randomizer(possible_ids: Array[String], volume_variance: float, pitch_variance: float, volume_base : float, pitch_base : float): #play sound with some random variance
	var id = possible_ids[randi_range(0,possible_ids.size() - 1)]
	var volume_modifier = randf_range(volume_variance, -volume_variance)
	var pitch_modifier = randf_range(pitch_variance, -pitch_variance)
	
	var randomized_volume = volume_base + volume_modifier
	var randomized_pitch = pitch_base + pitch_modifier
	play_sound(id, randomized_volume, randomized_pitch)
	
func play_sound_default(id: String, volume : float, pitch : float): #play sound default
	play_sound(id, volume, pitch)
