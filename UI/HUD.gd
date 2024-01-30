extends Control

@export var banana_scene: PackedScene

@onready var slap_label = $HBox/HBoxContainer2/Slap_Label
@onready var banana_hbox = $HBox/Margin/Banana_HBox


var bananas: Array[Node]
var gibbi: Gibbi

func change_kill_count():
	slap_label.text = str(GameManager.kill_count)

func remove_banana():
	if not bananas.is_empty():
		banana_hbox.remove_child(bananas.pop_back())

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	gibbi = Gibbi.Instance
	
	for i in gibbi.health:
		var banana = banana_scene.instantiate()
		bananas.append(banana)
		banana_hbox.add_child(banana)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_gibbi_enemy_killed():
	change_kill_count()
