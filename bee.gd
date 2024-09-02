extends Node2D


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var dead = false

func _ready():
	pass

func _process(delta):
	if dead == false:
		$AnimatedSprite2D.play("Idle")

func _on_area_entered(area):
	if area.is_in_group("Sword"):
		dead = true
		$AnimatedSprite2D.play("Dead")


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "Dead":
		queue_free()
