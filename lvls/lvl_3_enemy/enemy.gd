extends KinematicBody2D

var target: KinematicBody2D

func _ready():
	pass

func _process(delta):
	pass
	
func _on_Area2D_body_exited(body):
	# 
	if body.is_in_group("player"):
		target = body
