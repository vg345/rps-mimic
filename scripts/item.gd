extends Node2D

@export var my_type: String
var data:Dictionary
var init = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		if  data[my_type]["hurt_by"].has(area.get_parent().current_mode):
			global.score += 1
			%AudioStreamPlayer2D.play()
			%AnimationPlayerSpawn.play("despawn")
			await %AnimationPlayerSpawn.animation_finished
			queue_free()

func _ready():
	var json = FileAccess.get_file_as_string("res://scripts/data.json")
	data = JSON.parse_string(json)
	%AnimationPlayerSpawn.play("spawn")
	
func _process(_delta):
	if !init and my_type != null:
		if my_type == "rock":
			%rock.visible = true
		if my_type == "scissors":
			%scissors.visible = true
		if my_type == "paper":
			%paper.visible = true
		init = true
