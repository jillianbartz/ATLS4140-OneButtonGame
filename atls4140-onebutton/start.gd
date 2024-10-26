extends Node2D

func _ready():
	get_tree().paused = false

func _input(event):
	if event.is_action_pressed("Space"):
		get_tree().change_scene_to_file("res://main.tscn")
