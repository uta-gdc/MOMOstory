extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var _animated_sprite = $AnimatedSprite2D
var direction = 0
func _process(_delta):
	if Input.is_action_pressed("ui_right"):
		direction = Input.get_axis("ui_left", "ui_right")
		_animated_sprite.play("run_right")
	elif Input.is_action_pressed("ui_left"):
		direction = Input.get_axis("ui_left", "ui_right")
		_animated_sprite.play("run_left")
	elif Input.is_action_pressed("ui_down"):
		if(direction > 0):
			_animated_sprite.play("prone_right")
		else:
			_animated_sprite.play("prone_left")
	else:
		print(direction)
		if(direction > 0):
			_animated_sprite.play("stand_right")
		else:
			_animated_sprite.play("stand_left")
		
# broken code for exercise		
#func _process(_delta):
	#if Input.is_action_pressed("ui_right"):
		#_animated_sprite.play("right_run")
	#elif Input.is_action_pressed("ui_left"):
		#_animated_sprite.play("left_run")
	#else:
		#_animated_sprite.stop()
	#
	#if Input.is_action_just_released("ui_right"):
		#_animated_sprite.play("right_stand")
	#
	#if Input.is_action_just_released("ui_left"):
		#_animated_sprite.play("left_stand")
	

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
