extends Node3D

@export var rainAudioStreamPlayerNodePath: NodePath
@onready var rainAudioStreamPlayer: AudioStreamPlayer = get_node(rainAudioStreamPlayerNodePath)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if (body.is_in_group("player")):
		AudioServer.set_bus_mute(1,true)


func _on_area_3d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if (body.is_in_group("player")):
		AudioServer.set_bus_mute(1,false)
