extends KinematicBody2D

# Nodos:
onready var animationPlayer  := $AnimationPlayer
onready var animationSprite  := $AnimatedSprite
onready var timer			 := $Timer
onready var rayCast          := $RayCast2D

# Propiedades generales
export var velocity: int = 2500				# Velocidad de movimiento
export var dammage: int = 1					# Daño del enemigo
export var max_time_to_wait: int = 5		# Tiempo maximo de espera para moverse
export var min_time_to_wait: int = 0		# Tiempo minimo de espera

# Variables:
var target: KinematicBody2D					# Variable donde guaramos a target
var target_pos: Vector2 = Vector2.ZERO		# Posición del target a donde moverse
var dir: Vector2 = Vector2.ZERO				# Vector de dirección
var tolerancia: int = 10					# Tolerancia de desplazamiento
var movement_range: int = 100				# Rango de movimiento aleatorio


func _process(delta):
	# Si el target pos es distinto de zero
	if target_pos != Vector2.ZERO:
		# Si hay target:
		if target:
			# Asignamos la posición del target 
			target_pos = target.position
		# Si la distancia hacia target es mayor a la tolerancia
		if (target_pos - position).length() > tolerancia:
			# Reproducimos animación de correr
			animationPlayer.play("run")
			# Rotamos el sprite en dirección hacia el target
			animationSprite.flip_h = (target_pos.x - position.x) < 0
			# Asignamos a dir la dirección hacia el target
			dir = (target_pos - position).normalized()*velocity*delta
			# Movemos el enemigo hacia el jugador
			dir = move_and_slide(dir , Vector2.UP)
		# Si no tiene target
		else:
			# Reproducimos animación estar
			animationPlayer.play("idle")

# Señales:
func _on_Area2D_body_exited(body):
	# Si body esta en el grupo player
	if body.is_in_group("player"):
		# asigna body a target
		target = null


func _on_Area2D_body_entered(body):
	# Si body esta en el grupo player
	if body.is_in_group("player"):
		# asigna body a target
		target = body

func _on_Timer_timeout():
	# Actualizamos la semilla aleatoria
	randomize()
	# Cambiamos el tiempo de espera por un numero entre timepo minimo y maximo 
	timer.wait_time = rand_range(min_time_to_wait , max_time_to_wait)
	# Mientras sea verdad:
	while true:
		# Nueva posicion sera un vector altearorio 
		var new_pos = Vector2(rand_range(-movement_range,movement_range),
							rand_range(-movement_range,movement_range))
		# Apuntamos el raycast hacia la nueva posición
		rayCast.cast_to = new_pos
		# Forzamos actualización del raycast
		rayCast.force_raycast_update()
		# Si no hay colisión con el raycast
		if !rayCast.get_collider():
			# Actualizamos la posicion hacia donde moverse.
			target_pos = position + new_pos
			# Salimos del while
			break


func _on_Area2D2_body_entered(body):
	# si el body es del grupo player
	if body.is_in_group("player"):
		# llama a hit del player
		body.hit(dammage, (target_pos - position).normalized())
