extends Node
@export var music_player : AudioStreamPlayer
@export var animator : AnimationPlayer
signal music_started
signal music_ended

var music_dict : Dictionary = {
	"Overworld" : preload("res://Audio/Music/blindside_overworld.mp3")
}

func transition_to_track(name: String):
	if music_player.stream == music_dict.get(name):
		return
	if music_player.is_playing():
		await fade_out_track()
	await fade_in_track(name)
	
func cut_to_track(name: String):
	if music_player.is_playing():
		end_current_track()
	play_track(name)

func play_track(name: String):
	if !music_dict.has(name):
		push_error("Track not found: " + name)
		return
	music_player.stream = music_dict[name]
	music_player.play()
	music_started.emit()

func end_current_track():
	music_player.stop()
	music_player.stream = null
	music_ended.emit()
	
func fade_out_track():
	animator.play("Music/FadeOut")
	await animator.animation_finished
	end_current_track()
		
func fade_in_track(name: String):
	play_track(name)
	animator.play("Music/FadeIn")
	await animator.animation_finished
