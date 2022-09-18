extends KinematicBody2D

class_name SimpleUnit2D							# Nombre de la clase

var position_to_move: Vector2 = Vector2.ZERO 	# Posicion a donde moverse
var tolerance: int = 20						 	# Tolerancia de hasta donde moverse
var speed: int= 600								# Velocidad de movimiento

# Prototipo de la funcion process
func _process(delta: float) -> void:
	pass

# Prototipo de la funcion atacar
func atack():
	pass

func move_to_pos(new_position: Vector2,speed: int) -> Vector2:
	if new_position.length() > tolerance:
		return (new_position - position).normalized() * speed
	return Vector2.ZERO
