class_name Zoo_Visitor_01BaseState
extends Node


var state_machine : Zoo_Visitor_01StateMachine
var character : Zoo_Visitor_01


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
