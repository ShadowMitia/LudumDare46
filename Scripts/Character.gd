extends KinematicBody2D

signal show_text(text, duration, dissapears)

onready var TextUI = get_node("../HUD/Control")
export(float) var SPEED = 200

var energy = 0

func evaluate_energy():
	if (energy >= 10):
		emit_signal("show_text", "You feel the forest reaching out to you.", 1, 3)
		

func _physics_process(delta):
	
	var velocity = Vector2.ZERO;
	
	velocity.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left");
	velocity.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up");	
	velocity = velocity.normalized()
	velocity *= SPEED
	
	velocity = move_and_slide(velocity, Vector2.ZERO)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name.substr(0, 9) == "Dead Tree":
			collision.collider.set_velocity(-collision.normal)
		# print("Collided with: ", collision.collider.name)

func _on_TutorialObjective_body_entered(body):
	if body.name.substr(0, 9) == "Dead Tree":
		energy += 50
		evaluate_energy()

func _on_WaterfallObjective_body_entered(body):
	if body.name.substr(0, 9) == "Dead Tree":
		energy += 50
		evaluate_energy()

func _on_Puzzle2Objective_body_entered(body):
	if body.name.substr(0, 9) == "Dead Tree":
		energy += 50
		evaluate_energy()
