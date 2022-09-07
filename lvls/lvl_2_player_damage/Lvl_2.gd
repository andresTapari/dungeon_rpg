extends Node2D

onready var player := $player
onready var camera := $Camera2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.connect('player_damagged',self,'handle_player_damagged')

func handle_player_damagged()->void:
	camera.add_trauma(.8)
