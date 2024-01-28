extends Node


@onready var player = $Player


func _physics_process(delta) -> void:
	get_tree().call_group("enemy", "update_target_location", player.global_transform.origin)

