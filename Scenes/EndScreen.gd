extends Node2D

onready var timer = $Timer
onready var background = $CanvasLayer/ColorRect
onready var tween = $Tween
onready var theEnd = $CanvasLayer/CenterContainer/TheEnd
onready var thanks = $CanvasLayer/CenterContainer/Label


func show_credits():
	background.show()

	background.modulate = Color(1, 1, 1, 0)
	var start = background.modulate
	var end = start
	end.a = 1
	tween.interpolate_property(background, "modulate",start, end, 2, Tween.TRANS_CUBIC)
	tween.start()

func show_end():
	theEnd.show()
	theEnd.percent_visible = 0
	tween.interpolate_property(theEnd, "percent_visible",0, 1, 4, Tween.TRANS_CUBIC)
	
func show_thanks():
	theEnd.hide()
	thanks.show()

func _on_Tween_tween_completed(object, key):
	if object == background and key == ":modulate":
		show_end()
	elif object == theEnd and key == ":percent_visible":
		timer.start()


func _on_Timer_timeout():
	show_thanks()
