extends StaticBody2D

signal collision_bounce()

var wasHit = false

onready var collisionShape = $"BlockCollide"


func _on_Area2D_body_entered(body):

	if wasHit:
		return
	
	if body.name == "Ball":
		visible = false
		wasHit = true
		get_node("BlockCollide").set_deferred("disabled", true)
