extends SimpleUnit2D

func _ready() -> void:
	pass

func _process(delta) -> void:
	# Rotamos el sprite
	$AnimatedSprite.flip_h = (target_pos.x - position.x) < 0
	# Asignamos animacion
	if current_state == state.IDLE:
		$AnimatedSprite.play("idle")
	elif current_state == state.RUN:
		$AnimatedSprite.play("run")
