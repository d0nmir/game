extends CharacterBody3D

@onready var sound_jump: AudioStreamPlayer = $sound_jump
@onready var animated_sprite_3d: AnimatedSprite3D = $Pivot/AnimatedSprite3D
@onready var sound_walk: AudioStreamPlayer = $sound_walk
@onready var battle_ui: CanvasLayer = $"../BattleUI"
@onready var main_camera: Camera3D = $MainCamera
@onready var cutscene_camera: Camera3D = $"../CutsceneCamera"
@onready var cutscene_animation: AnimationPlayer = $"../CutsceneAnimation"

signal turn_done()
signal died(character: Node3D)


@export_group("Movement")
@export var move_speed := 14
@export var jump_impulse := 20
@export var fall_acceleration := 60
@export var is_frozen := false

var target_velocity = Vector3.ZERO


func _physics_process(delta):
	var direction = Vector3.ZERO
	
	if Input.is_action_just_pressed("esc"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
	if not is_frozen:
		if Input.is_action_pressed("move_right"):
			direction.x += 1
			animated_sprite_3d.flip_h = false
		if Input.is_action_pressed("move_left"):
			direction.x -= 1
			animated_sprite_3d.flip_h = true
		if Input.is_action_pressed("move_forward"):
			direction.z -= 1
		if Input.is_action_pressed("move_back"):
			direction.z += 1
		
	if direction != Vector3.ZERO:
		direction = direction.normalized()
	
	target_velocity.x = direction.x * move_speed
	target_velocity.z = direction.z * move_speed
	
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
		
	if is_on_floor() and Input.is_action_just_pressed("jump") and not is_frozen:
		target_velocity.y = jump_impulse
		sound_jump.play()
		
	velocity = target_velocity
	
	if velocity.x != 0 or velocity.z != 0 and is_on_floor():
		if !sound_walk.playing:
			sound_walk.play()
	elif sound_walk.playing:
		sound_walk.stop()
	
	_set_animation()
	move_and_slide()
	
func _set_animation():
	var horizontal_speed = Vector3(velocity.x, 0, velocity.z).length()
	
	if not is_on_floor():
		if target_velocity.y > 0.1:
			animated_sprite_3d.play("jump")
		else:
			animated_sprite_3d.play("fall")
	elif horizontal_speed > 0.1:
		animated_sprite_3d.play("run")
	else:
		animated_sprite_3d.play("idle")

		
func _on_player_killer_body_entered(body: Node3D) -> void:
	get_tree().reload_current_scene()



	
