extends Node2D

@export var current_mode:String
var data:Dictionary

func _ready():
	var json = FileAccess.get_file_as_string("res://scripts/data.json")
	data = JSON.parse_string(json)
	current_mode = "blob"

func reset():
	%blob.visible = true 
	%rock.visible = false
	%paper.visible = false
	%scissors.visible = false
	current_mode = "blob"

func set_sprite():
	%blob.visible = false 
	%rock.visible = false
	%paper.visible = false
	%scissors.visible = false
	if current_mode == "blob":
		%blob.visible = true
	if current_mode == "rock":
		%rock.visible = true	
	if current_mode == "scissors":
		%scissors.visible = true	
	if current_mode == "paper":
		%paper.visible = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	if current_mode == "blob":
		current_mode = area.get_parent().my_type
		set_sprite()
	if data[current_mode]["hurt_by"].has(area.get_parent().my_type):
		global.game_over = true
