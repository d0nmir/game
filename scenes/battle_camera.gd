extends Camera3D

var is_shaking := false


func shake_pos(intensity: float = 0.02, duration: float = 0.25):
	if is_shaking: return
	is_shaking = true
	
	var time_left := duration
	var start_position = position
	
	while time_left > 0:
		var offset := Vector3(randf_range(-intensity, intensity), randf_range(-intensity, intensity), 0.0)
		
		position = start_position + offset
		time_left -= get_process_delta_time()
		
		await get_tree().process_frame
		
	position = start_position
	is_shaking = false
