extends Node3D
#
#@export var soundDistortionPath: NodePath
#@onready var soundDistortionAnimation: AnimationPlayer = get_node(soundDistortionPath)

@export var rainSoundPath: NodePath
@onready var rainSound: AudioStreamPlayer = get_node(rainSoundPath)

@export var playerPath: NodePath
@onready var player: CharacterBody3D = get_node(playerPath)

# Called when the node enters the scene tree for the first time.
func _ready():
	rainSound.pitch_scale = 1


var playerInArea = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if playerInArea:
		var distanceToPlayer = (global_position - player.global_position).length()
		rainSound.pitch_scale = clamp((distanceToPlayer-5)/18,0.05,1)


func _on_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if (body.is_in_group("player")):
		playerInArea=true
		print("starting distortion")
		rainSound.pitch_scale = .5


func _on_area_3d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	playerInArea = false
	rainSound.pitch_scale = 1
