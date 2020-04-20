extends Node2D


func _ready():
	hide()


func _on_WaterfallObjective_body_entered(body):
	if body.name.substr(0, 9) == "Dead Tree":
		show()
