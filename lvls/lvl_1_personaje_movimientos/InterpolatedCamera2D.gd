extends Camera2D

export (float) var lerp_speed = .5			# Amortiguación de desplasamiento
export (NodePath) var target_path = null	# Path del nodo a seguir


var target: Node = null


func _ready():
	# Si el path target es valido:
	if target_path:
		# asignamos el nodo a target
		target = get_node(target_path)

func _process(delta: float) -> void:
	# Si no hay 
	if !target:
		# sale del proceso
		return
	# Asignamos la posicion del target a la camara 
	self.position = lerp(self.position, target.position, lerp_speed)

#func _draw():
#	draw_line(Vector2(0,0), Vector2(50, 50), Color(255, 0, 0), 1)
