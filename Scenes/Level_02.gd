extends Node

signal level_complete()
signal block_was_hit(n)
var count = 0

func _ready():
	for i in range(1, self.get_child_count()):
		self.get_child(i).connect("number_was_hit", self, "_on_Block_number_was_hit")

func _on_Block_number_was_hit(n):
	count = count + n
	
	emit_signal("block_was_hit", n)
	
	print_debug(str(count))
	
	if count >= 29:
		emit_signal("level_complete")
