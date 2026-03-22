extends Area3D

@onready var main_camera: Camera3D = $"../Player/MainCamera"
@onready var battle_camera: Camera3D = $"../Player/BattleCamera"
@onready var cutscene_camera: Camera3D = $"../CutsceneCamera"
@onready var cutscene_animation: AnimationPlayer = $"../CutsceneAnimation"
@onready var hint_button_2: AnimatedSprite3D = $"../Enemy/hint_button2"
@onready var player: CharacterBody3D = $"../Player"
@onready var battle_sound: AudioStreamPlayer = $"../Battle_sound"
@onready var bg_sound: AudioStreamPlayer = $"../Bg_sound"


var player_inside = false
var is_dialogue_started = false

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if "Player" in body.name:
		player_inside = true
		hint_button_2.show()

func _on_body_exited(body: Node3D) -> void:
	if "Player" in body.name:
		player_inside = false
		hint_button_2.hide()

func _physics_process(delta: float) -> void:
	if player_inside:
		if Input.is_action_just_pressed("interaction") and not is_dialogue_started:
			bg_sound.stop()
			battle_sound.play()
			is_dialogue_started = true
			player.is_frozen = true 
			hint_button_2.hide()
			CameraTransition.transition_camera3D(main_camera, cutscene_camera)
			await get_tree().create_timer(2).timeout
			cutscene_animation.play("dummy_appear")
			await get_tree().create_timer(1.5).timeout
			CameraTransition.transition_camera3D(cutscene_camera, battle_camera)
			await get_tree().create_timer(1.5).timeout
			$"../BattleUI".show()
			$"../Enemy".show()
			
