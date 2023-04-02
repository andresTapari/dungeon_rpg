extends TextureProgress

func update_value(topValue: int, _value: int) -> void:
	# Establecemos el valor maximo
	max_value = topValue
	# Establecemos el valor actual
	value = _value
	# Si el valor es mayor a 70%
	if value > 0.7*topValue:
		# Coloreamos la barra de progreso en verde
		tint_progress = Color.green
	# Si el valor es menor al 70% y mayor al 30%
	elif value > 0.3*topValue:
		# Coloreamos la barra de progreso en naranja
		tint_progress = Color.orange
	# Si es menos a 30%
	else:
		# Coloreamos la barra de progreso en rojo
		tint_progress = Color.red
