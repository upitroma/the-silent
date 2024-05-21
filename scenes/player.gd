extends CharacterBody3D
@export var speed = 10
@export var jump_velocity = 4.5
@export var mouse_sensitivity = .002
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var velocity_y = 0

@onready var camera:Camera3D = $playerCamera
func _physics_process(delta):
	var horizontal_velocity = Input.get_vector("move_left","move_right","move_forward","move_back").normalized() * speed
	velocity = horizontal_velocity.x * global_transform.basis.x + horizontal_velocity.y * global_transform.basis.z
	if is_on_floor():
		velocity_y = jump_velocity if Input.is_action_just_pressed("jump") else 0
	else: velocity_y -= gravity * delta
	velocity.y = velocity_y
	move_and_slide()
	if Input.is_action_just_pressed("ui_cancel"): 
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE else Input.MOUSE_MODE_VISIBLE

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$playerCamera.rotate_x(-event.relative.y * mouse_sensitivity)
		$playerCamera.rotation.x = clampf($playerCamera.rotation.x, -deg_to_rad(70), deg_to_rad(70))
