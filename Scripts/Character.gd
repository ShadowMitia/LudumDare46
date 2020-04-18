extends KinematicBody2D

export(float) var SPEED = 200

func _ready():
	pass
	
func _physics_process(delta):
	
	var velocity = Vector2.ZERO;
	
	velocity.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left");
	velocity.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up");	
	
	velocity *= SPEED
	
	move_and_slide(velocity, Vector2.ZERO)
