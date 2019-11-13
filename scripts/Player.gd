extends KinematicBody2D

onready var GameWorldNode = get_parent()
onready var BulletScene = preload("res://scenes/Bullet.tscn")

const UP = Vector2(0, -1)
const SLOPE_THRESHOLD = 0.8
const GRAVITY = 500
const SPEED = 400

var motion = Vector2()
var is_on_ladder = false;

func _ready():
	motion.y = GRAVITY
	is_on_ladder = false
	change_anim("idle", 1)
	
	pass

func _physics_process(delta):

	if(is_on_floor() or is_on_ladder):
		if(Input.is_action_pressed("ui_right")):
			motion.x = SPEED
			change_anim("walk_right", 1.6)
		elif(Input.is_action_pressed("ui_left")):
			motion.x = -SPEED
			change_anim("walk_left", 1.6)
		else:
			motion.x = 0
	else:
		motion.x = 0
	
	motion.y = GRAVITY
	
	if(is_on_ladder):
		if(Input.is_action_pressed("ui_down")):
			change_anim("climb_ladder", 2)
			motion.y = SPEED * 0.7
			motion.x = 0
		elif(Input.is_action_pressed("ui_up")):
			change_anim("climb_ladder", 2)
			motion.y = -SPEED * 0.7
			motion.x = 0
		else:
			motion.y = 0
	
	if(Input.is_action_just_pressed("ui_select")):
		shoot()
	
	motion = move_and_slide(50 * motion * delta, UP, SLOPE_THRESHOLD)
	
	pass

func shoot():
	var bullet_instance = BulletScene.instance()
	bullet_instance.position = position
	bullet_instance.z_index = 0
	GameWorldNode.add_child(bullet_instance)
	change_anim("shoot", 1)
	
	pass

func change_anim(new_animation, animation_speed):
	#If the animation is new,
	if (new_animation != get_node("AnimationPlayer").get_current_animation()):
		#print(newanim)
		get_node("AnimationPlayer").play(new_animation) #Change it!
		get_node("AnimationPlayer").playback_speed = animation_speed

func _on_Ladder_body_entered(body):
	if(body.is_in_group("players")):
		is_on_ladder = true
	
	pass
	
func _on_Ladder_body_exited(body):
	if(body.is_in_group("players")):
		is_on_ladder = false
	
	pass

func _on_Area2D_body_entered(body):
	if(body.is_in_group("enemies")):
		queue_free()
	
	pass
