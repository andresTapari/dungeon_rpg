extends KinematicBody2D

# Señales:
signal player_damagged


export var speed = 200

# Nodos:
onready var animatedSprite 	:= $AnimatedSprite
onready var weaponAim 		:= $AnimatedSprite/WeaponAim
onready var animationPlayer := $AnimationPlayer
onready var knockBackTimer  := $KnockBackTimer

# Variables:
var dir: Vector2 		  = Vector2.ZERO		# Vector direccion del personaje
var velocity: Vector2 	  = Vector2.ZERO		# Vector velocidad del personaje
var knockBackDir: Vector2 = Vector2.ZERO		# Dirección de impulso hacia atras
var knockBackForce: int   = 2000				# Fuerca de empuje
var playerHitted: bool    = false				# Bandera si player fue golpeado

var maxHealth = 10
var health = maxHealth

# Loop principal:
func _physics_process(delta):
	# Rotamos el arma en dirección del arma:
	weaponAim.look_at(get_global_mouse_position())
	# Si el mouse esta a la derecha del personaje:
	if get_global_mouse_position().x - position.x > 0:
		# Rotamos el sprite de animación hacia la derecha
		animatedSprite.scale.x = 1
	# Si el mouse esta a la izquierda del personaje: 
	else:
		# Rotamos el sprite de animación hacia la izquierda
		animatedSprite.scale.x = -1
	# Reiniciamos el vector direccion
	dir = Vector2.ZERO
	# Si presionamos el boton derecho:
	if Input.is_action_pressed("ui_right"):
		# Vector dir.x = 1
		dir.x = 1
	# Si presionamos el boton izquierdo:
	if Input.is_action_pressed("ui_left"):
		# Vector dir.x = -1
		dir.x = -1
	# Si presionamos el boton arribda:
	if Input.is_action_pressed("ui_up"):
		# Vector dir.y = -1
		dir.y = -1
	# Si presionamos el boton abajo
	if Input.is_action_pressed("ui_down"):
		# Vector dir.y = 1
		dir.y = 1
	# Si el vector dirección es cero: 
	if dir == Vector2.ZERO:
		# nodo de animación reproduce "estar"
		animatedSprite.play("idle")
	# si no:
	else:
		# nodo de animación reproduce "correr"
		animatedSprite.play("run")
	# Si precionamos la tecla hit
	if Input.is_action_just_pressed("ui_hit"):
		# Reproducimos la animación wepaon hit:
		animationPlayer.play("weapon hit")
	
	# Si player se encuentra golpeado
	if playerHitted:
		# se mueve en direccion del golpe
		velocity = move_and_slide(knockBackDir*knockBackForce*delta,Vector2.UP)
		# reproduce la animación hit
		animatedSprite.play('hit')
	else:
		# Cargamos la dirección normalizada por la velocidad en el vector velocidad.
		velocity = dir.normalized() * speed * delta
	
	# Movemos el personaje
	velocity = move_and_slide(velocity,Vector2.UP)
	
#	update()

func hit(damage: int) -> void:
	health -= damage
	# dirección de salto hacia atras sera inverso a dir
	knockBackDir = -dir
	# establecemos estado de player golpeado = true
	playerHitted = true
	# iniciamos el timer
	knockBackTimer.start()
	# emitimos señal de player golpeado para sacudir la camara
	emit_signal('player_damagged')	

func _on_AnimationPlayer_animation_finished(_anim_name):
	# Cuando termina la animación reproducimos idle
	animationPlayer.play("weapon idle")

func _on_KnockBackTimer_timeout() -> void:
	# cuando termina el tiempo de knockback
	# estado de player golpeado es falso
	playerHitted = false
