extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -350.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D
@onready var attack_area = $AttackArea
@onready var collision_shape = $AttackArea/CollisionShape2D  # Access the CollisionShape2D directly

var is_attacking = false

func _ready():
	animated_sprite.connect("animation_finished", Callable(self, "_on_AnimatedSprite2D_animation_finished"))

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if not is_attacking:
			animated_sprite.play("Jump")

	if Input.is_action_just_pressed("r") and is_on_floor():
		is_attacking = true
		animated_sprite.play("Attack1")
		collision_shape.disabled = false  # Enable the hitbox during the attack

	var direction = Input.get_axis("left", "right")

	if direction > 0:
		animated_sprite.flip_h = false
		attack_area.scale.x = 1  # Ensure the hitbox faces right
	elif direction < 0:
		animated_sprite.flip_h = true
		attack_area.scale.x = -1  # Flip the hitbox to face left

	if is_on_floor() and not is_attacking:
		if direction == 0:
			animated_sprite.play("Idle")
		else: 
			animated_sprite.play("Run")
	else:
		if not is_attacking:
			animated_sprite.play("Jump")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_animated_sprite_2d_animation_finished():
	print("Animation finished: ", animated_sprite.animation)
	if animated_sprite.animation == "Attack1":
		collision_shape.disabled = true  # Disable the hitbox after the attack
		is_attacking = false
		handle_movement_animation()


func handle_movement_animation():
	var direction = Input.get_axis("left", "right")
	
	if is_on_floor() and not is_attacking:
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Run")
	else:
		animated_sprite.play("Jump")
