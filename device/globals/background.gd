extends Control

export var action = "walk"

func input(event):
	if event is InputEventMouseButton && event.pressed:
		if (event.button_index == 1):
			get_tree().call_group_flags(SceneTree.GROUP_CALL_DEFAULT, "game", "clicked", self, get_position() + Vector2(event.position.x, event.position.y))
		elif (event.button_index == 2):
			emit_right_click()

func get_action():
	return action

func _init():
	add_user_signal("right_click_on_bg")

func _ready():
	connect("gui_input", self, "input")
	add_to_group("background")

func emit_right_click():
	emit_signal("right_click_on_bg")
