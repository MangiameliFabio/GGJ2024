extends Node


@export
var MeshNode : MeshInstance3D

@export
var ShirtMaterial : ShaderMaterial

@export
var MaterialIndex = 1

@export
var StartColor : Color = Color(0.8, 0.4, 0.8)


# Called when the node enters the scene tree for the first time.
func _ready():
	StartColor.h = randf()
	
	ShirtMaterial.set_shader_parameter("Color", StartColor)
	MeshNode.set_surface_override_material(MaterialIndex, ShirtMaterial)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
