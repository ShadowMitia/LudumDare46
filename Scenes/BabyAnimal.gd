extends KinematicBody2D

export(float) var SPEED = 200
export(float) var WALK_UPDATE_SPEED = 0.5

var walk_alternate = true

var follow_character = false
var follow_target = null

onready var timer = $Timer

var rng = RandomNumberGenerator.new()

var velocity = Vector2.ZERO

func get_random_direction():
	return rng.randi() % 3 - 1

func _ready():
	rng.randomize()
	
	timer.wait_time = WALK_UPDATE_SPEED
	timer.start()

func _physics_process(delta):
	velocity = move_and_slide(velocity)


func _on_Timer_timeout():
	if walk_alternate and !follow_character:
		var dir_x = get_random_direction()
		var dir_y = get_random_direction()
		
		velocity = Vector2(dir_x, dir_y)
		velocity = velocity.normalized() * SPEED
	elif walk_alternate and follow_character:
		velocity = follow_target.position - position
		if velocity.length() > 450:
			follow_character = false
			follow_target = null
		if velocity.length() > 50:
			velocity = velocity.normalized() * SPEED
		else:
			velocity = Vector2.ZERO
	else:
		velocity = Vector2.ZERO

	walk_alternate = !walk_alternate

func _on_Area2D_body_entered(body):
	if body.name == "Character":
		follow_character = true
		follow_target = get_node("../Character")


func _on_BabyAnimalObjective_body_entered(body):
	if body == self:
		follow_character = false
		
		get_node("../Character").energy += 100
		
		follow_target = null
		$Area2D.monitoring = false
