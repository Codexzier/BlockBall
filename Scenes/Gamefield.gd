extends Node

var gameIsRunning = true

# Punktestand
var punktestand_player = 0

# Leben
var leben = 3

# Referenzen
onready var node_player = $"Game_Objects/Player"
onready var node_ball = $"Game_Objects/Ball"
onready var node_timer = $"Control_Objects/Reset_timer"
onready var node_start_timer = $"Control_Objects/Start_timer"
onready var node_hud_punktestand = $"HUD/Punktestand"

# ursprungspositionen
var start_position_player
var start_position_ball

# level scence
var scene_level

func _ready():
		
	scene_level = load("res://Scenes/Level_01.tscn").instance()
	$Level_Objects/Blocks.add_child(scene_level)
	scene_level.connect("level_complete", self, "_on_Level_01_level_complete")
	scene_level.connect("block_was_hit", self, "_on_Level_block_was_hit")
	
	start_position_player = node_player.position
	start_position_ball = node_ball.position
	
	_set_reset()
	node_start_timer.start()
	
func _input(event):
	
	if gameIsRunning:
		return
	
	if event.is_action_pressed("enter"):
		gameIsRunning = true
		
		completReset()
		_set_reset()

func _on_Area2D_body_entered(body):
	if body.name == "Ball":
		node_ball.movement = Vector2(0, abs(node_ball.speed))
		leben -= 1
		
		#$"Control_Objects/Sound_lost".play()
		if leben == 2:
			$"HUD/Live3".visible = false
		elif leben == 1:
			$"HUD/Live2".visible = false
		elif leben == 0:
			$"HUD/Live1".visible = false
		else:
			$"HUD/Game Over".visible = true
			gameIsRunning = false
			return
		
		node_timer.start()
		_set_reset()

func completReset():
	punktestand_player = 0
	leben = 3
	$"HUD/Live3".visible = true
	$"HUD/Live2".visible = true
	$"HUD/Live1".visible = true
	

func _set_reset():
	node_player.position = start_position_player
	node_ball.position = start_position_ball
	
	node_player.can_move = false
	node_ball.can_move = false

func _on_Reset_Timer_timeout():
	node_player.can_move = true
	node_ball.can_move = true

#func _on_Ball_collision_bounce_block():
#	punktestand_player += 1
#	node_hud_punktestand.text = str(punktestand_player)
#
#	if punktestand_player >= 32:
#		_set_reset()
#		$"HUD/Finish".visible = true
#		node_ball.visible = true
	
func _on_Start_timer_timeout():
	node_timer.start()


func _on_Level_01_level_complete():
	_set_reset()
	node_timer.start()
	
	# entlade level 1
	scene_level.disconnect("level_complete", self, "_on_Level_01_level_complete")
	scene_level.disconnect("block_was_hit", self, "_on_Level_block_was_hit")
	$Level_Objects/Blocks.remove_child(scene_level)
		
	# lade level 2
	scene_level = load("res://Scenes/Level_02.tscn").instance()
	$Level_Objects/Blocks.add_child(scene_level)
	scene_level.connect("level_complete", self, "_on_Level_02_level_complete")
	scene_level.connect("block_was_hit", self, "_on_Level_block_was_hit")
	
func _on_Level_02_level_complete():
	_set_reset()
	$"HUD/Finish".visible = true
	node_ball.visible = false
	
func _on_Level_block_was_hit(n):
	punktestand_player += 1
	node_hud_punktestand.text = str(punktestand_player)
	
#	if punktestand_player >= 32:
#		_set_reset()
#		$"HUD/Finish".visible = true
#		node_ball.visible = true
