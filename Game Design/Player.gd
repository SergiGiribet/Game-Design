@icon("res://assets/kenney_scribbledungeons/Player.png")

extends Character

@onready var sprite = $Sprite2D

func _process(_delta: float) -> void:
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()

	if mouse_direction.x > 0 and sprite.flip_h:
		sprite.flip_h = false
	elif mouse_direction.x < 0 and not sprite.flip_h:
		sprite.flip_h = true

		
func get_input() -> void:
	mov_direction = Vector2.ZERO
	if Input.is_action_pressed("ui_down(s)"):
		mov_direction += Vector2.DOWN
	if Input.is_action_pressed("ui_left(a)"):
		mov_direction += Vector2.LEFT
	if Input.is_action_pressed("ui_right(d)"):
		mov_direction += Vector2.RIGHT
	if Input.is_action_pressed("ui_up(w)"):
		mov_direction += Vector2.UP


