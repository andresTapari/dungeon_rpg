class_name SimpleUnit2D							# Nombre de la clase

extends KinematicBody2D							# Extiende el nodo Kinematic

# Nodos:
onready var timerAtck:   Timer     = Timer.new()
onready var timerMove:   Timer     = Timer.new()
onready var moveRayCast: RayCast2D = RayCast2D.new()

# Variables de la clase unit:
export var time_to_wait_min: int = 1					# Tiempo de espera minimo
export var time_to_wait_max: int = 5					# Tiempo de espera maximo
export var move_speed: int   = 600						# Velocidad de movimiento
export var move_range: int   = 10						# Radio de movimiento
export var atck_speed: float = 1						# Tiempo de espera entre ataques 
export var atck_range: int   = 10 						# Rango de ataque
export var dammage: int = 2								# Daño de la unidad

var direction_to_move: Vector2 = Vector2.ZERO 			# Posicion a donde moverse
var target_pos: Vector2 = Vector2.ZERO					# Posicion del target
var distance_tolerance: int = 10						# Tolerancia de hasta donde moverse

var target: Node = null									# Target a atacar
var atk_enable: bool = false								# Si esta ataca

# Funciones internas del engine:

func _ready():
	# Configuracion del timer Move:
	timerMove.set_one_shot(false)
	timerMove.set_timer_process_mode(1)
	timerMove.set_wait_time(time_to_wait_min)
	timerMove.connect("timeout", self, "_on_timerMove_time_out")
	self.add_child(timerMove)
	timerMove.start()
	
	# Configuracion del timer atck
	timerAtck.set_one_shot(false)
	timerAtck.set_timer_process_mode(1)
	timerAtck.set_wait_time(time_to_wait_min)
	timerAtck.connect("timeout", self, "_on_timerAtck_time_out")
	self.add_child(timerAtck)
	#timerAtck.start()

	# Configuracion del rayCast
	moveRayCast.enabled = true
	moveRayCast.cast_to = Vector2(0,50)
	self.add_child(moveRayCast)

func _process(delta: float) -> void:
	# Si el target pos es distinto de zero
	if target_pos != Vector2.ZERO:
		# Si hay target:
		if target:
			# Asignamos la posición del target 
			target_pos = target.position

		# Si la distancia hacia target es mayor a la tolerancia
		if (target_pos - position).length() > distance_tolerance:
			# Asignamos a dir la dirección hacia el target
			direction_to_move = (target_pos - position).normalized()*move_speed*delta
			# Movemos el enemigo hacia el jugador
			direction_to_move = move_and_slide(direction_to_move , Vector2.UP)

	if atk_enable:
		
		if (target_pos - position).length() < atck_range:
			target.hit(dammage, (target_pos - position).normalized())
			atk_enable = false

# Prototipo de la funcion atacar
func atack() -> void:
	pass

# Prototipo de la funcion hit
func move() -> void:
	pass

# Prototipo de la función 
func move_to_pos(new_position: Vector2,speed: int) -> Vector2:
	if new_position.length() >= distance_tolerance:
		return (new_position - position).normalized() * speed
	return Vector2.ZERO

# Señales:
func _on_timerMove_time_out() -> void:
	# Actualizamos la semilla aleatoria
	randomize()
	# Cambiamos el tiempo de espera por un numero entre timepo minimo y maximo 
	timerMove.wait_time = rand_range(time_to_wait_min , time_to_wait_max)
	# Mientras sea verdad:
	while true:
		# Nueva posicion sera un vector altearorio 
		var new_pos = Vector2(rand_range(-move_range,move_range),
							rand_range(-move_range,move_range))
		# Apuntamos el raycast hacia la nueva posición
		moveRayCast.cast_to = new_pos
		# Forzamos actualización del raycast
		moveRayCast.force_raycast_update()
		# Si no hay colisión con el raycast
		if !moveRayCast.get_collider():
			# Actualizamos la posicion hacia donde moverse.
			target_pos = position + new_pos
			# Salimos del while
			break

func _on_timerAtck_time_out() -> void:
	pass
