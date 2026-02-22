extends Interactable

@onready var fruit_puzzle: FruitPuzzle = $"%FruitPuzzle"
@export var weight: int

func _on_interact():
	fruit_puzzle.add_item(weight)
	self.visible = false
