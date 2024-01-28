extends Node


@export
var MeshNode : MeshInstance3D

@export
var ShirtMaterial : ShaderMaterial


# Called when the node enters the scene tree for the first time.
func _ready():
	var shirtcolor : Color = Color(0.8, 0.4, 0.8)
	shirtcolor.h = randf()
	
	ShirtMaterial.set_shader_parameter("Color", shirtcolor)
	MeshNode.set_surface_override_material(1, ShirtMaterial)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
