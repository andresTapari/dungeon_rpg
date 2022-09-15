extends KinematicBody2D

var target: KinematicBody2D						#Variable donde guaramos a target


func _ready():
	pass

func _process(delta):
	pass
	
func _on_Area2D_body_exited(body):
	# Si body esta en el grupo player
	if body.is_in_group("player"):
		# asigna body a target
		target = body
