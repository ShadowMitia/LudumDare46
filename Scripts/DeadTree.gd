extends KinematicBody2D

var velocity = Vector2.ZERO setget set_velocity
export(float) var SPEED = 100
export(bool) var one_time = false
var moved_one_time = false

export(int, "both axis", "horizontal", "vertical") var direction = 0;
var moving = false

func set_velocity(val):
	moving = true
	velocity = val * SPEED
	if direction == 1:
		velocity.y = 0
	elif direction == 2:
		velocity.x = 0

func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if moving and !moved_one_time:
		var collider = move_and_collide(velocity * delta)
		if collider:
			moving = false
			velocity = Vector2.ZERO
			if one_time:
				moved_one_time = true

func _on_Objective_body_entered(body):
	if body == self:
		set_collision_mask_bit(0, true)


func _on_TutorialObjective_body_entered(body):
	if body == self:
		set_collision_mask_bit(0, true)
