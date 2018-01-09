extends Area2D

export var action = "walk"
var collisionshape_click
var rectangleshape

func input(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.is_pressed():
		if (event.button_index == 1):
			get_tree().call_group_flags(SceneTree.GROUP_CALL_DEFAULT, "game", "clicked", self, get_position() + Vector2(event.position.x, event.position.y))
		elif (event.button_index == 2):
			emit_right_click()

func get_action():
	return action

func _init():
	add_user_signal("right_click_on_bg")

func _enter_tree():
	# Use size of background texture to calculate collision shape
	var background = get_parent().get_node("background")
	if background:
		var size = background.get_size()
		var extents = Vector2(size.x / 2, size.y / 2)
		var t = Transform2D(Vector2(1, 0), Vector2(0, 1), extents)

		var shape = RectangleShape2D.new()
		shape.set_extents(extents)
		if get_shape_owners().size() == 0:
			create_shape_owner(CollisionShape2D.new())
		shape_owner_add_shape(0, shape)
		shape_owner_set_transform(0, t)

func _ready():
	connect("input_event", self, "input")
	add_to_group("background")

func emit_right_click():
	emit_signal("right_click_on_bg")
