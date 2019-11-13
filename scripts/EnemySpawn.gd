extends Node2D

onready var GameWorldNode = get_parent()

func _ready():
	pass

func destroy():
	queue_free()
	var instance = get_node("Enemy").new()
	instance.position.y = 0
	GameWorldNode.add_child(instance)
	
	pass

func _on_Area2D_body_entered(body):
	if(body.is_in_group("players")):
		destroy()
	
	pass 