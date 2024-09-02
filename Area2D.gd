extends Area2D

@onready var timer = $Timer



func _on_body_entered(_body):
	if _body.is_in_group("Character"):
		print("You died! -10 Social Credit Score")
		timer.start()





func _on_timer_timeout():
	get_tree().reload_current_scene()
