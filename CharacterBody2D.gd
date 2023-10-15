extends CharacterBody2D

const speed = 550
const accel = 50
const friction = 40
const jump_power = -2000
const gravity = 150
const max_jumps = 10
var current_jumps = 1



func _physics_process(delta):
	var input_dir: Vector2 = input()
	
	if(input_dir) != Vector2.ZERO:
		accelerate(input_dir)
	else:
		add_friction()
	player_movement()
	jump()

func input() -> Vector2:
	var input_dir = Vector2.ZERO
	
	input_dir.x = Input.get_axis("ui_left", "ui_right")
	input_dir = input_dir.normalized()
	return input_dir
	
func accelerate(direction):
	velocity = velocity.move_toward(speed * direction, accel)
	
func add_friction():
	velocity = velocity.move_toward(Vector2.ZERO, friction)

func player_movement():
	move_and_slide()

func jump():
	if Input.is_action_just_pressed("ui_up"):
		if current_jumps < max_jumps:
			velocity.y = jump_power
			current_jumps = current_jumps + 1
	else:
		velocity.y += gravity
	if is_on_floor():
		current_jumps = 1
