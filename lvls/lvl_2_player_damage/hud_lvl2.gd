extends CanvasLayer

onready var progressBar := $TextureProgress

func _ready():
	pass # Replace with function body.

func updateProgressBarr(topValue: int, value: int) -> void:
	# Establecemos el valor maximo
	progressBar.max_value = topValue
	# Establecemos el valor actual
	progressBar.value = value
	# Si el valor es mayor a 70%
	if value > 0.7*topValue:
		# Coloreamos la barra de progreso en verde
		progressBar.tint_progress = Color.green
	# Si el valor es menor al 70% y mayor al 30%
	elif value > 0.3*topValue:
		# Coloreamos la barra de progreso en naranja
		progressBar.tint_progress = Color.orange
	# Si es menos a 30%
	else:
		# Coloreamos la barra de progreso en rojo
		progressBar.tint_progress = Color.red
