extends Area2D



func _on_body_entered(_body):
	print("+1 Social Credit Score")
	queue_free()
