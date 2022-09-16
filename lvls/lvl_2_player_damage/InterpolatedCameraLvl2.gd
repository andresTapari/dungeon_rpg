extends Camera2D

export (float) var lerp_speed = .5			# Amortiguación de desplasamiento
export (NodePath) var target_path = null	# Path del nodo a seguirs

export var decay = 0.8  					# How quickly the shaking stops [0, 1].
export var max_offset = Vector2(100, 75)  	# Maximum hor/ver shake in pixels.
export var max_roll = 0.1  					# Maximum rotation in radians (use sparingly).

onready var noise = OpenSimplexNoise.new()	# Ruido
var noise_y = 0								# Variable de ruido
var target: Node = null						# Objetivo a seguir	

var trauma = 0.0  # Current shake strength.
var trauma_power = 2  # Trauma exponent. Use [2, 3].

func _ready():
	# Si el path target es valido:
	if target_path:
		# asignamos el nodo a target
		target = get_node(target_path)
	randomize()
	noise.seed = randi()
	noise.period = 4
	noise.octaves = 2

func _process(delta: float) -> void:
	# Si no hay 
	if !target:
		# sale del proceso
		return
	# Asignamos la posicion del target a la camara 
	self.position = lerp(self.position, target.position, lerp_speed)
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()

func shake():
	var amount = pow(trauma, trauma_power)
	noise_y += 1
	rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	offset.x = max_offset.x * amount * noise.get_noise_2d(noise.seed*2, noise_y)
	offset.y = max_offset.y * amount * noise.get_noise_2d(noise.seed*3, noise_y)

func add_trauma(amount):
	trauma = min(trauma + amount, 1.0)


#func _draw():
#	draw_line(Vector2(0,0), Vector2(50, 50), Color(255, 0, 0), 1)
