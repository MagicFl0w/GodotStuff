extends CharacterBody2D

@export var speed = 300
var screen_size
var current_direction = PlayerDirection.down
var is_attacking = false
var is_moving = false
var input_direction
var animationPrefix = "idle_"
var animationSuffix = "down"
var testFlipped = false


enum PlayerDirection { up, down, left, right, idle }

func _ready():
	screen_size = get_viewport_rect().size

func get_input():
	input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed
	current_direction = input_direction



func _process(delta):
	playerAttack()

	# Prioritize attack animation
	if is_attacking:
		playAttackAnimation()
	else:
		updateWalkAnimation(current_direction)
		playIdleAnimation()
		

func _physics_process(delta):
	get_input()
	if input_direction:
		is_moving = true
		move_and_slide()
	else:
		is_moving = false
		if is_attacking:
			animationPrefix = "attack_"
			playAttackAnimation()
		else:
			animationPrefix = "idle_"
			playIdleAnimation()
	getPlayerDirection(input_direction)
	
	
	
	

func playerAttack():
	if Input.is_action_just_pressed("attack1"):
		is_attacking = true
		print("Attack button pressed, starting attack animation")
#		$AnimatedSprite2D.stop()
		animationPrefix = "attack_"
		




func getPlayerDirection(direction):
	var last_direction = direction
	if direction.x == 0 and direction.y == 1:
		current_direction = PlayerDirection.down
		animationPrefix = "run_"
		animationSuffix = "down"
	elif direction.x == 0 and direction.y == -1:
		current_direction = PlayerDirection.up
		animationPrefix = "run_"
		animationSuffix = "up"
	elif direction.x == -1 and direction.y == 0:
		current_direction = PlayerDirection.left
		animationPrefix = "run_"
		animationSuffix = "right"
	elif direction.x == 1 and direction.y == 0:
		current_direction = PlayerDirection.right
		animationPrefix = "run_"
		animationSuffix = "right"





func updateWalkAnimation(direction):
	match direction:
		PlayerDirection.up:
			$AnimatedSprite2D.play(animationPrefix + animationSuffix)
		# Play the "up" animation
		PlayerDirection.down:
		# Play the "down" animation
			$AnimatedSprite2D.play(animationPrefix + animationSuffix)
		PlayerDirection.left:
		# Play the "left" animation
			$AnimatedSprite2D.play(animationPrefix + animationSuffix)
			$AnimatedSprite2D.flip_h = true  # Flip the sprite horizontally
		PlayerDirection.right:
			# Play the "right" animation
			$AnimatedSprite2D.play(animationPrefix + animationSuffix)
			$AnimatedSprite2D.flip_h = false
			
			
			
func playIdleAnimation():
# left animation
	if $AnimatedSprite2D.flip_h == true:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play(animationPrefix + animationSuffix)
	else:
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play(animationPrefix + animationSuffix)
		
func playAttackAnimation():
	
		if $AnimatedSprite2D.flip_h == true:
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play(animationPrefix + animationSuffix)

		else:
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play(animationPrefix + animationSuffix)








func _on_animated_sprite_2d_animation_changed():
	pass
#	if is_attacking:
#		$AnimatedSprite2D.play("attack_down")
#	print("animation changed") # Replace with function body.


func _on_animated_sprite_2d_animation_finished():
	is_attacking = false
	print("animation finished") # Replace with function body.
