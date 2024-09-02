extends CharacterBody2D

@onready var animation_sprite = $AnimatedSprite2D

const jump_power = -450
const gravity = 50

func move(dir,speed):
	velocity.x = dir * speed
	handle_animation()
	update_dir(dir)

func update_dir(dir):
	if abs(dir) == dir:
		animation_sprite.flip_h = false
	else:
		animation_sprite.flip_h = true

func handle_animation():
	if !is_on_floor():
		animation_sprite.play("Idle")
	
	if velocity.x != 0:
		animation_sprite.play("Walk")
	else:
		animation_sprite.play("Idle")

func _physics_process(delta):
	if is_on_wall() and is_on_floor():
		velocity.y = jump_power
	else:
		velocity.y += gravity
	
	move(1,-50)
	move_and_slide()
