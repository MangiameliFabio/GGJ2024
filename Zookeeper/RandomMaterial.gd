extends Node

@export
var MeshNode : MeshInstance3D

@export
var MaterialIndex = 0

@export
var Personalities : Array[Personality]

var current_personality : Personality

@export
var audioPlayer : AudioStreamPlayer3D


# Called when the node enters the scene tree for the first time.
func _ready():
	current_personality = Personalities[randi_range(0, len(Personalities)-1)]
	var current_texture = current_personality.skinTextures.Skins[randi_range(0, len(current_personality.skinTextures.Skins)-1)]
	
	var SurfaceMaterial : BaseMaterial3D = MeshNode.get_active_material(MaterialIndex)
	SurfaceMaterial.albedo_texture =   current_texture
	
	
	
	pass # Replace with function body.


func play_hit_sound():
	audioPlayer.set_stream(current_personality.hitSound[randi_range(0, len(current_personality.hitSound)-1)])
	audioPlayer.play()
	
func play_attack_sound():
	audioPlayer.set_stream(current_personality.attackSound[randi_range(0, len(current_personality.attackSound)-1)])
	audioPlayer.play()

