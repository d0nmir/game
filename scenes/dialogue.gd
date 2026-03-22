extends CanvasLayer


func _ready() -> void:
	if $".".visible:
		$AnimationPlayer.play("text_run")
