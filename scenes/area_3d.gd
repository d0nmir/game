extends Area3D

@onready var npc: CharacterBody3D = $".."
@onready var d_camera: Camera3D = $"../d_camera"
@onready var main_camera: Camera3D = $"../../Player/MainCamera"
@onready var hint_button: AnimatedSprite3D = $"../hint_button"
@onready var player: CharacterBody3D = $"../../Player"
@onready var dialogue: CanvasLayer = $"../../Dialogue"

var player_inside = false
var is_dialogue_started = false

func _on_body_entered(body: Node3D) -> void:
	if "Player" in body.name:
		player_inside = true
		hint_button.show()


func _on_body_exited(body: Node3D) -> void:
	if "Player" in body.name:
		player_inside = false
		hint_button.hide()

func _physics_process(delta: float) -> void:
	if player_inside and Input.is_action_just_pressed("interaction") and not is_dialogue_started:
		CameraTransition.transition_camera3D(main_camera, d_camera)
		npc.current_animation = "talk"
		await get_tree().create_timer(0.5).timeout
		dialogue.show()
		player.is_frozen = true 
		is_dialogue_started = true
		hint_button.hide()
	elif player_inside and Input.is_action_just_pressed("interaction") and is_dialogue_started:
		CameraTransition.transition_camera3D(d_camera, main_camera)
		npc.current_animation = "idle"
		dialogue.hide()
		await get_tree().create_timer(1).timeout
		player.is_frozen = false
		is_dialogue_started = false
		hint_button.show()
	
		
