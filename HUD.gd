extends Control

onready var tween = $Tween
onready var timer = $Timer
onready var background = $Label/ColorRect

func remove_text():
	$Label.text = ""

func _ready():
	show() # Make sure text UI is always visible...
	remove_text()
	$Timer.wait_time = 3
	$Timer.start()
	show_text("On a late spring morning... Walking along your favorite path through the woods.", 3, 6)

func show_text(text, duration, disappears_after):
	print("Show text '", text, "' ", duration, ", ", disappears_after)
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
