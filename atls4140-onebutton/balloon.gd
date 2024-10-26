extends CharacterBody2D
var expand: bool = false

func _ready():
	global_scale.x = 20
	global_scale.y = 20

func _on_timer_timeout() -> void:
	if(expand):
		global_scale.x += .5
		global_scale.y += .5
		$BallonShape.global_scale.x += .5
		$BallonShape.global_scale.y += .5
		$Timer.start(.005)
	
func _input(event):
	if event.is_action_pressed("Space"):
		$Grow.play()
		global_scale.x += .5
		global_scale.y += .5
		$BallonShape.global_scale.x += .5
		$BallonShape.global_scale.y += .5
		$Timer.start(.005)
		expand = true
	if event.is_action_released("Space"):
		$Grow.stop()
		expand = false
		
