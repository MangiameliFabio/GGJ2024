class_name ZoovisitorBaseState
extends Node


var state_machine : ZoovisitorStateMachine
var character : Zoovisitor


# Recive user input
func handle_input(_event: InputEvent) -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	pass

#Called when state is entered
func enter(_msg := {}) -> void:
	pass

#Called when state is exited
func exit() -> void:
	pass
