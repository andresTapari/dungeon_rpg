extends KinematicBody2D

class_name SimpleUnit2D

var position_to_move: Vector2 = Vector2.ZERO # Posicion a donde moverse
var tolerance: int = 20						 # Tolerancia de hasta donde moverse

func _process(delta: float) -> void:
	var move = move_to_pos(Vector2(200,200),600)
	move = move_and_slide(move, Vector2.UP)

func move_to_pos(new_position: Vector2,speed: int) -> Vector2:
	if new_position.length() > tolerance:
		return (new_position - position).normalized() * speed
	return Vector2.ZERO
