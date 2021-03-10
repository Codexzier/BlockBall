extends KinematicBody2D

signal position_changed(y)
signal collision_bounce()
signal collision_bounce_block()

export var speed = 400
var movement = Vector2(0, speed)
var can_move = true

func _ready():
	position = get_viewport().size / 2

func _physics_process(delta):
	if can_move:
		var collison_info = move_and_collide(movement * delta)
		emit_signal("position_changed", position.x)
		
		if collison_info:
			emit_signal("collision_bounce")
						
			if collison_info.collider.name == "Player":
				speed = -speed
				var diff = collison_info.collider.position.x - position.x
				var newMovement = Vector2(-diff * 5, speed)
				movement = newMovement
			else:
				movement = movement.bounce(collison_info.normal)
				
				if str(collison_info.collider.name).begins_with("Block"):
					emit_signal("collision_bounce_block")


func resetMovement():
	movement = Vector2(0, speed)
