extends KinematicBody2D


# Variablen für den Spieler
var movement = Vector2(0,0)
export var speed = 400
var can_move = true

# Bewegung
func _physics_process(delta):
	if can_move:
		move_and_collide(movement * delta)

func _input(event):
	if event.is_action_pressed("left"):
		movement = Vector2(-speed, 0)
	elif event.is_action_pressed("right"):
		movement = Vector2(speed, 0)
	elif event.is_action_released("left") or event.is_action_released("right"):
		movement = Vector2(0,0)
