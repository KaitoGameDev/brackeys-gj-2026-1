class_name MainMenu extends Node3D

@onready var start_game_btn : Button = $Control/Container/StartGameBtn
@onready var credits_btn : Button = $Control/Container/CreditsBtn
@onready var back_btn : Button = $Control/BackBtn
@onready var camera_pivot: Node3D = $Tower/CameraPivot
@onready var camera: Camera3D = $Tower/CameraPivot/Camera3D
@onready var title: Label = $Control/Title
@onready var door_right := $Tower/DoorRight
@onready var door_left := $Tower/DoorLeft
@onready var world_environment: WorldEnvironment = $Tower/WorldEnvironment

var normal_camera_position := Vector3(0, 2.0, -16.0)
var credits_camera_position := Vector3(0, 16.0, -16.0)
var start_game_camera_position := Vector3(0, 1.0, -6.8)

func _ready() -> void:
	start_game_btn.pressed.connect(_on_start_btn_pressed)
	credits_btn.pressed.connect(_on_credits_btn_pressed)
	back_btn.pressed.connect(_on_back_btn_pressed)
	
	EventBusSingleton.send_event(GameInitiatedEvent.new())
	
func _process(delta: float) -> void:
	world_environment.environment.sky_rotation.y += delta * 0.025
		
func _on_start_btn_pressed() -> void:
	start_game_btn.visible = false
	credits_btn.visible = false
	title.visible = false
	
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(door_right, 'rotation_degrees:y', 120, 0.5)
	tween.tween_property(door_left, 'rotation_degrees:y', -120, 0.5)
	tween.tween_property(camera, 'position', start_game_camera_position, 0.5).set_delay(0.25)
	tween.finished.connect(
		func():
			get_tree().change_scene_to_file('res://source/main/main.tscn')
	)
	
func _on_credits_btn_pressed() -> void:
	start_game_btn.visible = false
	credits_btn.visible = false
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(camera_pivot, 'rotation_degrees:y', 180, 2.0)
	tween.tween_property(camera, 'position', credits_camera_position, 2.0)
	tween.finished.connect(
		func():
			back_btn.visible = true
	)
	
func _on_back_btn_pressed() -> void:
	back_btn.visible = false
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(camera_pivot, 'rotation_degrees:y', 0, 2.0)
	tween.tween_property(camera, 'position', normal_camera_position, 2.0)
	tween.finished.connect(
		func():
			start_game_btn.visible = true
			credits_btn.visible = true
	)
