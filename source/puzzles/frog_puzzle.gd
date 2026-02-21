class_name FrogPuzzle
extends Node3D

@export var valid_code: String
@export var buffer_size: int = 5
@export var reward_container: Node3D

var buffer: Array[String] = []
var has_been_resolved: bool = false

func add_char_to_buffer(character: String):
	if has_been_resolved:
		return

	buffer.append(character)
	buffer = buffer.slice(maxi(0, buffer.size() - 5), buffer.size())
	
	if buffer.size() < buffer_size:
		return
	
	if "".join(buffer) == valid_code:
		has_been_resolved = true
		reward_container.visible = true
