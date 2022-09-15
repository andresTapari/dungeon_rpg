extends Node2D

onready var player := $player
onready var camera := $Camera2D
onready var hud    := $CanvasLayer

func _ready() -> void:
	# Conectamos 
	player.connect('player_damagged',self,'handle_player_damagged')

func handle_player_damagged()->void:
	camera.add_trauma(.8)
	hud.updateProgressBarr(player.maxHealth , player.health)
