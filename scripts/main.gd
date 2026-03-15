extends Node2D
var item = preload("res://scenes/item.tscn")
var item_types = ["rock", "paper", "scissors"]
var one_time = true

func _process(_delta):
	%score.text = str(global.score)
	%hs.text = str(global.high_score)
	if !global.game_over:
		if Input.is_action_just_pressed("up"):
			var new_y = %player.global_position.y - 100
			%player.global_position.y = max(%pt1.global_position.y, new_y)
		if Input.is_action_just_pressed("down"):
			var new_y = %player.global_position.y + 100
			%player.global_position.y = min(%pt1.global_position.y + 700, new_y)
		if Input.is_action_just_pressed("left"):
			var new_x = %player.global_position.x - 100
			%player.global_position.x = max(%pt1.global_position.x, new_x)
		if Input.is_action_just_pressed("right"):
			var new_x = %player.global_position.x + 100
			%player.global_position.x = min(%pt1.global_position.x + 700, new_x)
		if Input.is_action_just_pressed("stop"):
			%player.reset()
	if global.game_over and one_time:
		game_is_over()
		one_time = false

func game_is_over():
	if global.score > global.high_score:
		global.high_score = global.score
		%new_hs.visible = true
	%spawnTimer.stop()
	%AudioStreamPlayer2D.stop()
	%AudioStreamGameOver.play()
	if %AudioStreamGameOver.stream_paused:
		%AudioStreamGameOver.stream_paused = false
	global.score = 0
	%over.visible = true

func _on_spawn_timer_timeout() -> void:
	var new_type = item_types.pick_random()
	var new_item = item.instantiate()
	new_item.my_type = new_type
	%items.add_child(new_item)
	shift_items()
	
func shift_items():
	var children = %items.get_children()
	children.reverse()
	if len(children) == 63:
		game_is_over()
	for i in len(children):
		if i < 63:
			children[i].global_position = %points.get_children()[i].global_position


func _on_restart_button_pressed() -> void:
	global.game_over = false
	get_tree().reload_current_scene()


func _on_down_button_pressed() -> void:
	var new_y = %player.global_position.y + 100
	%player.global_position.y = min(%pt1.global_position.y + 700, new_y)


func _on_left_button_pressed() -> void:
	var new_x = %player.global_position.x - 100
	%player.global_position.x = max(%pt1.global_position.x, new_x)


func _on_right_button_pressed() -> void:
	var new_x = %player.global_position.x + 100
	%player.global_position.x = min(%pt1.global_position.x + 700, new_x)


func _on_reset_button_pressed() -> void:
	%player.reset()

func _on_up_button_pressed() -> void:
	var new_y = %player.global_position.y - 100
	%player.global_position.y = max(%pt1.global_position.y, new_y)


func _on_close_inst_pressed() -> void:
	%Instructions.visible = false


func _on_mute_pressed() -> void:
	if %AudioStreamPlayer2D.playing:
		%AudioStreamPlayer2D.stop()
	else:
		%AudioStreamPlayer2D.play()
