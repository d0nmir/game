extends CanvasLayer
@onready var main_camera: Camera3D = $"../Player/MainCamera"
@onready var battle_camera: Camera3D = $"../Player/BattleCamera"
@onready var player: CharacterBody3D = $"../Player"
@onready var battle_sound: AudioStreamPlayer = $"../Battle_sound"
@onready var bg_sound: AudioStreamPlayer = $"../Bg_sound"
@onready var attack: AnimatedSprite3D = $"../Enemy/Marker3D/Attack"
@onready var attacks_player: AnimatedSprite3D = $"../Player/Marker3D/attacks_player"
@onready var hit_sound: AudioStreamPlayer = $"../Hit_sound"

@export var enemy_type = 0
@export var dummy_defeated = false

var current_player_health = 0
var current_enemy_health = 0
var is_defending

func _ready() -> void:
	set_health($MonsterUI/HealthBar,Game.dataBaseBoss[enemy_type]["Current_Health"], Game.dataBaseBoss[enemy_type]["Max_Health"] )
	set_health($PlayerUI/HealthBar, Game.dataBasePlayer[0]["Current_Health"], Game.dataBasePlayer[0]["Max_Health"])
	$PlayerUI/Menu/GridContainer/Fight.grab_focus()
	
	current_enemy_health = Game.dataBaseBoss[enemy_type]["Current_Health"]
	current_player_health = Game.dataBasePlayer[0]["Current_Health"]

func enemy_turn():
	current_player_health = max(0, current_player_health - Game.dataBaseBoss[enemy_type]["Attacks"][0]["Damage"])
	set_health($PlayerUI/HealthBar, current_player_health, Game.dataBasePlayer[0]["Max_Health"])
	
	$"../Enemy/AnimatedSprite3D".play("attack")
	hit_sound.play()
	await get_tree().create_timer(1).timeout
	$"../Enemy/AnimatedSprite3D".play("idle")
	
	if current_player_health == 0:
		$"../Enemy".hide()
		$".".hide()
		player.is_frozen = false
		get_tree().reload_current_scene()
		

func _on_fight_pressed() -> void:
	$PlayerUI/Menu.hide()
	$PlayerUI/Fight.show()
	$"PlayerUI/Fight/GridContainer/Attack 1".grab_focus()


func _on_back_pressed() -> void:
	$PlayerUI/Fight.hide()
	$PlayerUI/Menu.show()
	$PlayerUI/Menu/GridContainer/Fight.grab_focus()


func set_health(health_bar,health, max_health):
	health_bar.value = health
	health_bar.max_value = max_health
	health_bar.get_node("Label").text = "HP:%d/%d" % [health, max_health]
	


func _on_attack_1_pressed() -> void:
	current_enemy_health = max(0, current_enemy_health - Game.dataBasePlayer[0]["Attacks"][0]["Damage"])
	set_health($MonsterUI/HealthBar, current_enemy_health, Game.dataBaseBoss[enemy_type]["Max_Health"])
	attack.show()
	attack.play("tackle")
	hit_sound.play()
	await get_tree().create_timer(0.5).timeout
	attack.stop()
	$"../Enemy/AnimatedSprite3D".play("take_damage")
	
	await get_tree().create_timer(0.5).timeout
	$"../Enemy/AnimatedSprite3D".play("idle")
	await get_tree().create_timer(0.5).timeout
	if current_enemy_health == 0:
		$"../Enemy".hide()
		dummy_defeated = true
		player.is_frozen = false
		CameraTransition.transition_camera3D(battle_camera, main_camera)
		battle_sound.stop()
		bg_sound.play()
		
		$".".hide()
		return
	enemy_turn()


func _on_attack_2_pressed() -> void:
	current_enemy_health = max(0, current_enemy_health - Game.dataBasePlayer[0]["Attacks"][1]["Damage"])
	set_health($MonsterUI/HealthBar, current_enemy_health, Game.dataBaseBoss[enemy_type]["Max_Health"])
	attack.show()
	attack.play("scratch")
	hit_sound.play()
	await get_tree().create_timer(0.5).timeout
	attack.stop()
	$"../Enemy/AnimatedSprite3D".play("take_damage")
	
	await get_tree().create_timer(0.5).timeout
	$"../Enemy/AnimatedSprite3D".play("idle")
	await get_tree().create_timer(0.5).timeout
	if current_enemy_health == 0:
		$"../Enemy".hide()
		dummy_defeated = true
		player.is_frozen = false
		CameraTransition.transition_camera3D(battle_camera, main_camera)
		battle_sound.stop()
		bg_sound.play()
		$".".hide()
		return
	enemy_turn()
