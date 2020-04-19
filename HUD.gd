extends Control

onready var tween = get_node("Tween")

func remove_text():
	$Label.text = ""

func _ready():
	remove_text()

func show_text(text, duration, disappears_after):
	
	$Label.text = text
	$Label.visible_characters = 0
	
	tween.interpolate_property($Label, "percent_visible", 0, 1, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	if !tween.is_active():
		tween.start()
		$Timer.wait_time = disappears_after


func _on_Character_bumped_tree(text, duration=1, disappears_after=3):
	show_text(text, duration, disappears_after)


func _on_Timer_timeout():
	remove_text()
