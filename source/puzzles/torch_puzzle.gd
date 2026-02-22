class_name TorchPuzzle
extends Node3D

@export var color_torch_objects: Array[ColorTorch]
@export var reward_container: Node3D

var has_been_resolved = false

func validate():
	if has_been_resolved:
		return
		
	var required_torches = 0;
	var non_required_torches = 0;
	
	for torch in color_torch_objects:
		if torch.is_enabled:
			if torch.should_be_enabled:
				required_torches += 1
			else:
				non_required_torches += 1
	
	if non_required_torches <= 0 and required_torches == 3:
		EventBusSingleton.send_event(PlaySfxEvent.create('solved_puzzle'))
		has_been_resolved = true
		reward_container.visible = true
