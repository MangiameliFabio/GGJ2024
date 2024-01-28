extends Node

@export
var MeshNode : MeshInstance3D

@export
var MaterialIndex = 0

@export
var Textures : Array[Texture2D]



# Called when the node enters the scene tree for the first time.
func _ready():
	
	var SurfaceMaterial : BaseMaterial3D = MeshNode.get_active_material(MaterialIndex)
	SurfaceMaterial.albedo_texture = Textures[0]
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
