extends CharacterBody3D
@export var walkSpeed = 5
@export var sprintSpeed = 15
@export var jump_velocity = 4.5
@export var mouse_sensitivity = .002
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var velocity_y = 0


@export var footstepsAudioPlayerPath: NodePath
@onready var footstepsAudioPlayer: AudioStreamPlayer = get_node(footstepsAudioPlayerPath)


@onready var camera:Camera3D = $playerCamera
func _physics_process(delta):
	var horizontal_velocity_direction = Input.get_vector("move_left","move_right","move_forward","move_back").normalized()
	
	# if sprinting
	var speed = 0
	if Input.is_action_pressed("sprint"):
		speed = sprintSpeed
	else:
		speed = walkSpeed
	
	var horizontal_velocity = horizontal_velocity_direction * speed
	
	
	velocity = horizontal_velocity.x * global_transform.basis.x + horizontal_velocity.y * global_transform.basis.z
	if is_on_floor():
		velocity_y = 0
	else: velocity_y -= gravity * delta
	velocity.y = velocity_y
	move_and_slide()
	
	
	# game window focus
	if Input.is_action_just_pressed("click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if Input.is_action_just_pressed("ui_cancel"): 
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	# footsteps
	if horizontal_velocity.length() != 0 and not footstepsAudioPlayer.playing:
		footstepsAudioPlayer.play()
	elif horizontal_velocity.length() == 0 and footstepsAudioPlayer.playing:
		footstepsAudioPlayer.stop()

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$playerCamera.rotate_x(-event.relative.y * mouse_sensitivity)
		$playerCamera.rotation.x = clampf($playerCamera.rotation.x, -deg_to_rad(70), deg_to_rad(70))
