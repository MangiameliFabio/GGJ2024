extends ZoovisitorBaseState


@onready var zoovisitor_animation_player = $"../../Zookeeper_Model".get_node("AnimationPlayer")


func handle_input(_event: InputEvent) -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	pass


func enter(_msg := {}) -> void:
	zoovisitor_animation_player.play("EnemyAttack_Begin")
	print("charge")


func exit() -> void:
	pass

