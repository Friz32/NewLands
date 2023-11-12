extends Node

@onready var info: RichTextLabel = %Info
@onready var transition: ColorRect = %Transition

var time: float = 1.0 / 24.0 * 9.0:
	set(value):
		time = wrap(value, 0, 1)

var previous_scene: Node

func _ready():
	info.visible = false

func _input(event):
	if InputMap.has_action("info") && event.is_action_pressed("info"):
		info.visible = !info.visible
	
	if InputMap.has_action("fullscreen") && event.is_action_pressed("fullscreen"):
		var mode = DisplayServer.WINDOW_MODE_FULLSCREEN if \
			DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED else \
			DisplayServer.WINDOW_MODE_WINDOWED
		
		DisplayServer.window_set_mode(mode)
	
	if InputMap.has_action("screenshot") && event.is_action_pressed("screenshot"):
		var image = get_viewport().get_texture().get_image()
		DirAccess.make_dir_absolute("user://screenshots")
		image.save_png("user://screenshots/" + Time.get_date_string_from_system() + "_" + Time.get_time_string_from_system().replace(":", ".") + ".png")

func _unhandled_input(event):
	if InputMap.has_action("quit") && event.is_action_pressed("quit"):
		get_tree().quit()

func _process(delta):
	info.text = "FPS: %s" % Engine.get_frames_per_second()
	
	if get_tree().current_scene != previous_scene && SaveSystem.save_data.player_scene && SaveSystem.save_data.player_scene.resource_path == get_tree().current_scene.scene_file_path:
		var player = Res["scn_player"].instantiate()
		player.position = SaveSystem.save_data.player_position
		# Bug: нет проверки наличия player_parent в сцене
		var parent = get_tree().current_scene if SaveSystem.save_data.player_parent.is_empty() else get_tree().current_scene.get_node(SaveSystem.save_data.player_parent)
		parent.add_child(player)
		
		transition.get_node("AnimationPlayer").play("fade_out")
	
	previous_scene = get_tree().current_scene

func on_timeout() -> void:
	time += 0.01
