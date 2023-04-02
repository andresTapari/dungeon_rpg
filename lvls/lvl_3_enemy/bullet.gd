extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	position += global_transform.x*600*delta
	pass


func _on_bullet_body_entered(body: Node) -> void:
	if body.is_in_group("enemy"):
		body.hurt(2)
		queue_free()
