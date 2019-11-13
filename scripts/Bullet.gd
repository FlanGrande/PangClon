extends RigidBody2D

func _ready():
	change_anim("bullet", 4)
	pass

func change_anim(new_animation, animation_speed):
	#If the animation is new,
	if (new_animation != get_node("AnimationPlayer").get_current_animation()):
		#print(newanim)
		get_node("AnimationPlayer").play(new_animation) #Change it!
		get_node("AnimationPlayer").playback_speed = animation_speed

func destroy():
	queue_free()
	
	pass

func _on_Area2D_body_entered(body):
	if(body.is_in_group("platforms")):
		destroy()
	
	pass
