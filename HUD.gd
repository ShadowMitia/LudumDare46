extends Control

onready var tween = $Tween
onready var timer = $Timer
onready var background = $Label/ColorRect

var showing_text = false

func remove_text():
	$Label.text = ""

func _ready():
	show() # Make sure text UI is always visible...
	remove_text()
	show_text("On a late spring morning... Walking along your favorite path through the woods.", 3, 6)

func show_text(text, duration, disappears_after):
	showing_text = true
	$Label.text = text
	$Label.visible_characters = 0
	background.show()

	tween.interpolate_property($Label, "percent_visible", 0, 1, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	if !tween.is_active():
		tween.start()
		$Timer.wait_time = disappears_after
		$Timer.start()

func _on_Timer_timeout():
	remove_text()
	background.hide()
	showing_text = false



func _on_Character_show_text(text, duration, dissapears):
	if showing_text:
		remove_text()
		tween.stop_all()
		tween.reset_all()
		$Timer.stop()
	show_text(text, duration, dissapears)
