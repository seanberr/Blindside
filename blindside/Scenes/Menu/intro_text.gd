extends Label

func advance_text(new_text: String):
	$AnimationPlayer.play("FadeOut")
	await $AnimationPlayer.animation_finished
	text = new_text
	$AnimationPlayer.play("FadeIn")
