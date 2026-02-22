extends Node3D

@onready var key_item : KeyItem = $KeyItem

func _ready() -> void:
	key_item.touched.connect(_on_touched)
	
func _on_touched() -> void:
	get_tree().change_scene_to_file('res://source/main/main_menu.tscn')
