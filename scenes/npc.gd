extends CharacterBody3D

@export var current_animation := "idle"

func _physics_process(delta: float) -> void:
	$AnimatedSprite3D.play(current_animation)
