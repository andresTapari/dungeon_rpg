extends Area2D

onready var animationPlayer := $AnimationPlayer

export var damage:int  = 200

var enable:bool = true

func _on_trapSpike_body_entered(body):
	if enable:
		animationPlayer.play("hit")
		body.hit(damage)
