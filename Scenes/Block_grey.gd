extends StaticBody2D

signal number_was_hit(n)

var wasHit = false

onready var collisionShape = $"BlockCollide"

export var Number = 0

func _on_Area2D_body_entered(body):

	if wasHit:
		return
	
	if body.name == "Ball":
		visible = false
		wasHit = true
		get_node("BlockCollide").set_deferred("disabled", true)
		emit_signal("number_was_hit", Number)
		
