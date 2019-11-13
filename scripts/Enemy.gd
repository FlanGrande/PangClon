extends RigidBody2D

onready var GameWorldNode = get_parent()
onready var EnemyScene = preload("res://scenes/EnemyHalf.tscn")

export var speed_x = 200

func _ready():
	linear_velocity.x = speed_x
	
	pass

func _physics_process(delta):
	
	pass

func destroy():
	queue_free()
	var enemy_half_instance_right = EnemyScene.instance()
	enemy_half_instance_right.position = Vector2(position.x + 32, position.y)
	
	var enemy_half_instance_left = EnemyScene.instance()
	enemy_half_instance_left.position = Vector2(position.x - 32, position.y)
	enemy_half_instance_left.linear_velocity.x = -100
	
	GameWorldNode.add_child(enemy_half_instance_right)
	GameWorldNode.add_child(enemy_half_instance_left)
	
	pass

func _on_Area2D_body_entered(body):
	if(body.is_in_group("bullets")):
		destroy()
		body.destroy()
	
	if(body.is_in_group("enemies")):
		add_collision_exception_with(body)
	
	pass
