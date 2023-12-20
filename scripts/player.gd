extends CharacterBody2D
class_name Player

const MAX_FALL_SPEED = 500

@export var gravity = 400
@export var movement_speed = 125
@export var jump_force = 200

@onready var animated_sprite = $AnimatedSprite2D

var active = true

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity * delta
		velocity.y = minf(velocity.y, MAX_FALL_SPEED)
	
	var direction = 0
	if active:
		if  is_on_floor() && Input.is_action_just_pressed("jump"):
			velocity.y = -jump_force
			AudioPlayer.play_sound_effect("player_jump")
		
		direction = Input.get_axis("move_left", "move_right")
	
	if direction != 0:
		animated_sprite.flip_h = (direction == -1)
	
	velocity.x = direction * movement_speed
	move_and_slide()
	
	update_animation(direction)

func jump(force):
	velocity.y = -force
	AudioPlayer.play_sound_effect("spring_boing")

func update_animation(direction):
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		if velocity.y < 0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")
