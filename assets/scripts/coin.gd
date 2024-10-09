extends Area2D



func _on_body_entered(_body):
	if _body.is_in_group("Character"):
		print("+1 Social Credit Score")
		queue_free()
