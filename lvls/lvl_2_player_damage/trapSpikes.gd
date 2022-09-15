extends Area2D

# Nodos:
onready var animationPlayer := $AnimationPlayer
onready var timer := $Timer

# Variables:
export var damage:int  = 200

var enable:bool = true

# Señales:
func _on_trapSpike_body_entered(body):
	if enable:
		animationPlayer.play("hit")
		body.hit(damage)
		timer.start()

func _on_Timer_timeout():
	animationPlayer.play("clear")
