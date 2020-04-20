extends KinematicBody2D

export(float) var SPEED = 200

var energy = 0 setget add_energy, get_energy


func add_energy(new_energy):
	energy += new_energy

func get_energy():
	return energy
	

	
func _physics_process(delta):
	
	var velocity = Vector2.ZERO;
	
	velocity.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left");
	velocity.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up");	
	
	velocity *= SPEED
	
	velocity = move_and_slide(velocity, Vector2.ZERO)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name.substr(0, 9) == "Dead Tree":
			collision.collider.set_velocity(-collision.normal)
		# print("Collided with: ", collision.collider.name)

func _on_TutorialObjective_body_entered(body):
	if body == self:
		self.add_energy(10)

func _on_WaterfallObjective_body_entered(body):
	if body == self:
		self.add_energy(50)
