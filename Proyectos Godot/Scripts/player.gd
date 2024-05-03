extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var weapon = "hammer"

# Refereces
@onready var animated_sprite = $AnimatedSprite2D
@onready var hammer_attack = $Hammer_attack
@onready var sword_attack = $Sword_attack
@onready var hammer_animations = %Hammer_animations
@onready var sword_animations = %Sword_animations

func _process(delta):
	if Input.is_action_just_pressed("change_weapon"):
		if weapon == "hammer":
			weapon = "sword"
			hammer_attack.visible = false
			sword_attack.visible = true
		else:
			weapon = "hammer"
			hammer_attack.visible = true
			sword_attack.visible = false
	if Input.is_action_just_pressed("attack"):
		if weapon == "hammer":
			hammer_animations.play("attack")
		else:
			sword_animations.play("attack")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	#Flip the sprite and hitboxes
	if direction > 0:
		animated_sprite.flip_h = false
		hammer_attack.scale.x = 1
		sword_attack.scale.x = 1
	elif direction < 0:
		animated_sprite.flip_h = true
		hammer_attack.scale.x = -1
		sword_attack.scale.x = -1
	
	#Play animations
	if direction == 0:
		animated_sprite.play("Idle")
	else:
		animated_sprite.play("Run")
	if not is_on_floor():
		animated_sprite.play("Jump")
	
	#Move the player
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
