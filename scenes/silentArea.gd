extends Node3D

@export var soundDistortionPath: NodePath
@onready var soundDistortionAnimation: AnimationPlayer = get_node(soundDistortionPath)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if (body.is_in_group("player")):
		print("starting distortion")
		soundDistortionAnimation.play("silenceAreaEntering")


func _on_area_3d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if (body.is_in_group("player")):
		soundDistortionAnimation.play_backwards("silenceAreaEntering")
