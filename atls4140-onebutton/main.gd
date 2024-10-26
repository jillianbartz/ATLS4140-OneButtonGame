extends Node2D

var within_limit: bool = true
var score_text: = " "

# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	get_tree().paused = false
	var rand_num = randf_range(150, 400)
	$Limit/LimitCollision.global_scale.x = rand_num
	$Limit/LimitCollision.global_scale.y = rand_num
	if(Global.health == 3):
		$Heart1.visible = true
		$Heart2.visible = true
		$Heart3.visible = true
	elif(Global.health == 2):
		$Heart1.visible = true
		$Heart2.visible = true
		$Heart3.visible = false
	else:
		$Heart1.visible = true
		$Heart2.visible = false
		$Heart3.visible = false
	$Round.start(4)
	

func _process(float):
	var limit = round($Limit/LimitCollision.global_scale.x)
	var balloon = round($Balloon/BallonShape.global_scale.x)
	if(round($Balloon/BallonShape.global_scale.x) > round($Limit/LimitCollision.global_scale.x)):
		print("pop")
		Global.health -= 1
		$PopLabel.visible = true
		get_tree().paused = true
		await get_tree().create_timer(1).timeout
		$PopLabel.visible = false
		if(Global.health == 0):
			Global.health = 3
			get_tree().change_scene_to_file("res://end.tscn")
		else:
			get_tree().reload_current_scene()
	elif(balloon == limit):
		print("perfect!")
		score_text = "Perfect!"
	elif((limit - balloon) < 5):
		print("amazing!")
		score_text = "Amazing!"
	elif((limit - balloon) < 30):
		print("great!")
		score_text = "Great!"
	elif((limit - balloon) < 60):
		print("okay!")
		score_text = "Okay!"


func _on_round_timeout() -> void:
	print("round over")
	if(score_text == "Perfect!" || score_text == "Amazing!"):
		$Balloon/Win2.play()
		$Label.text = score_text
		await $Balloon/Win2.finished
	else:
		$Balloon/Win1.play()
		$Label.text = score_text
		await $Balloon/Win1.finished
	
	get_tree().reload_current_scene()
