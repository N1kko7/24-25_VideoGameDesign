extends Area2D

@onready var timer = $Timer



func _on_body_entered(_body):
	print("You died! -10 Social Credit Score")
	timer.start()




func _on_timer_timeout():
	get_tree().reload_current_scene()
